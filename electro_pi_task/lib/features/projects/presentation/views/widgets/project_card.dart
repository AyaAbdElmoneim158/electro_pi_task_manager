import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/project_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _ProjectMenuAction { edit, delete }

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project, required this.onTap});
  final ProjectModel project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final completedTasks = project.todos.where((e) => e.completed).length;
    // final progress = project.todos.isEmpty ? 0.0 : completedTasks / project.todos.length;

    final statusColor = switch (project.status) {
      ProjectStatus.completed => Colors.green,
      ProjectStatus.inProgress => Colors.blue,
      ProjectStatus.pending => Colors.orange,
    };

    final statusText = switch (project.status) {
      ProjectStatus.completed => "Completed",
      ProjectStatus.inProgress => "In Progress",
      ProjectStatus.pending => "Pending",
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Status
                Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                    //   decoration: BoxDecoration(
                    //     color: statusColor.withOpacity(.12),
                    //     borderRadius: BorderRadius.circular(4),
                    //   ),
                    //   child: Icon(Icons.folder, color: statusColor),
                    // ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 14),

                                /// Description
                                Text(
                                  project.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(.12),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  statusText,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ), //!More -------------------------------------------------------
                              PopupMenuButton<_ProjectMenuAction>(
                                tooltip: "More",
                                icon: const Icon(Icons.more_vert),
                                onSelected: (action) async {
                                  switch (action) {
                                    case _ProjectMenuAction.edit:
                                      final updatedProject = await showModalBottomSheet<ProjectModel>(
                                        context: context,
                                        isScrollControlled: true,
                                        showDragHandle: true,
                                        builder: (_) => AddProjectBottomSheet(project: project),
                                      );

                                      if (!context.mounted || updatedProject == null) return;
                                      context.read<ProjectsCubit>().updateProject(updatedProject);
                                      break;

                                    case _ProjectMenuAction.delete:
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
                                      // Navigator.pop(context);
                                      context.read<ProjectsCubit>().getProjects();
                                      break;
                                  }
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: _ProjectMenuAction.edit,
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_outlined),
                                        SizedBox(width: 12),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: _ProjectMenuAction.delete,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //!-------------------------------------------------------
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Icon(
                      Icons.task_alt_rounded,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "$completedTasks / ${project.todos.length} Tasks",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
