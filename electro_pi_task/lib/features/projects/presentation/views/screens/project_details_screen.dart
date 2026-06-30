import 'package:electro_pi_task/core/constants/app_assets.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/todos_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/todos_state.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/project_info_card.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/custom_sliver_app_bar.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/task_card.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/todo_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen(this.projectModel, this.userName, {super.key});
  final ProjectModel projectModel;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: TodoFloatingActionButton(project: projectModel),
      body: RefreshIndicator(
        onRefresh: () async {}, //async => await context.read<TodosCubit>().refreshTodos(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverAppBar(userName: userName, onSearch: (value) {}, onFilter: () async {}),
            ),
            BlocBuilder<TodosCubit, TodosState>(
              // buildWhen: (_, current) => current is TodosLoaded,
              // buildWhen: (_, current) => current is TodosLoading || current is TodosLoaded || current is TodosError,
              // buildWhen: (_, current) => current is! TodosLoading,

              builder: (context, state) {
                if (state is TodosLoading) {
                  return const SliverFillRemaining(hasScrollBody: false, child: Center(child: CircularProgressIndicator()));
                }

                if (state is TodosError) {
                  return SliverFillRemaining(hasScrollBody: false, child: Center(child: Text(state.message)));
                }
                if (state is TodosLoaded) {
                  List<TodoModel> todos = state.todos;
                  return SliverMainAxisGroup(
                    slivers: [
                      //? Counter
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                          child: Text(
                            'Tasks (${todos.length})',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      //? Empty
                      if (todos.isEmpty)
                        SliverFillRemaining(
                            hasScrollBody: false,
                            child: //Text("No tasks found"),
                                Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * .8,
                                    child: AspectRatio(
                                      aspectRatio: 3.2,
                                      child: SvgPicture.string(
                                        AppAssets.themedTaskNotFoundIllustration,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No tasks Found",
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Pull to refresh or create a new task.",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ))

                      //? Todos
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                          sliver: SliverList.builder(
                            itemCount: todos.length,
                            itemBuilder: (_, index) {
                              final todo = todos[index];
                              return TaskCard(
                                task: todo,
                                projectId: projectModel.id,
                              );
                            },
                          ),
                        ),
                    ],
                  );
                }

                return SliverToBoxAdapter(child: const SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}
