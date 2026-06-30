
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/project_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectInfoCard extends StatelessWidget {
  const ProjectInfoCard({super.key, required this.project});
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xffFFF4E9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.folder_outlined,
              color: Color(0xffFF9800),
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _StatusChip(project.status.name),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Created on 20 May 2024",
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: "Edit Project",
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            final updatedProject = await showModalBottomSheet<ProjectModel>(
                              context: context,
                              isScrollControlled: true,
                              showDragHandle: true,
                              builder: (_) => AddProjectBottomSheet(project: project),
                            );
                            if (!context.mounted || updatedProject == null) return;
                            context.read<ProjectsCubit>().updateProject(updatedProject);
                          },
                        ),
                        IconButton(
                          tooltip: "Delete Project",
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Delete Project"),
                                content: Text(
                                  "Are you sure you want to delete '${project.title}'?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  FilledButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (!context.mounted || shouldDelete != true) return;
                            context.read<ProjectsCubit>().deleteProject(project.id);
                            Navigator.pop(context);
                            context.read<ProjectsCubit>().getProjects();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _StatusChip extends StatelessWidget {
  const _StatusChip(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffEAF2FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Color(0xff4285F4),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
