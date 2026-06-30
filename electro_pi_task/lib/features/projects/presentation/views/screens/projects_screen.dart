import 'package:electro_pi_task/core/constants/app_assets.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_state.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/empty_projects_state.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/project_card.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/project_card_shimmer.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/project_filter_bottom_sheet.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/project_floating_action_button.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ProjectFloatingActionButton(),
      body: RefreshIndicator(
        onRefresh: () async => await context.read<ProjectsCubit>().refreshProjects(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverAppBar(
                onSearch: (value) {
                  context.read<ProjectsCubit>().searchProjects(value);
                },
                onFilter: () async {
                  final cubit = context.read<ProjectsCubit>();
                  final status = await showModalBottomSheet<ProjectStatus?>(
                    context: context,
                    showDragHandle: true,
                    builder: (_) => ProjectFilterBottomSheet(selectedStatus: cubit.currentFilter),
                  );
                  if (!context.mounted) return;
                  cubit.filterProjects(status);
                },
              ),
            ),
            BlocBuilder<ProjectsCubit, ProjectsState>(
              buildWhen: (_, current) => current is! ProjectsLoading,
              builder: (context, state) {
                if (state is ProjectsLoading) return ProjectsLoadingWidget();
                if (state is ProjectsError) return ProjectsErrorWidget(state.message);
                if (state is ProjectsLoaded) return ProjectsBodyGroup(projects: state.projects);

                return SliverToBoxAdapter(child: const SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsLoadingWidget extends StatelessWidget {
  const ProjectsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 90),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, __) => const ProjectCardShimmer(),
          childCount: 7,
        ),
      ),
    );
  }
}

class ProjectsErrorWidget extends StatelessWidget {
  const ProjectsErrorWidget(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: AspectRatio(
                  aspectRatio: 1.7,
                  child: SvgPicture.string(
                    AppAssets.themedErrorIllustration,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Oops!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              // const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.read<ProjectsCubit>().refreshProjects(),
                icon: const Icon(Icons.refresh),
                label: const Text("Try Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectsBodyGroup extends StatelessWidget {
  const ProjectsBodyGroup({super.key, required this.projects});

  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        //? Counter
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
              "${projects.length} Projects",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),

        //? Empty
        if (projects.isEmpty)
          const SliverFillRemaining(hasScrollBody: false, child: EmptyProjectsState())

        //? Projects
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
            sliver: SliverList.builder(
              itemCount: projects.length,
              itemBuilder: (_, index) {
                final project = projects[index];

                return ProjectCard(
                  project: project,
                  onTap: () {
                    final userName = context.read<AuthCubit>().user?.name ?? "Guest";
                    Navigator.pushNamed(
                      context,
                      AppRoutes.projectDetailsRouter,
                      arguments: [project, userName],
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
