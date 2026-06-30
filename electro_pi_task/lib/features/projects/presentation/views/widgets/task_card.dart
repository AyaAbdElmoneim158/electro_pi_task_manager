import 'package:electro_pi_task/core/theme/app_style.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/todos_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/todo_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _TodoMenuAction { edit, delete }

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.projectId});
  final TodoModel task;
  final String projectId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(18),
      decoration: AppStyles.cardDecoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            task.completed ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: task.completed ? const Color(0xff6C63FF) : Colors.grey,
          ),
          // !
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                _StatusDot(title: task.status.name),
              ],
            ),
          ),
          const SizedBox(width: 10),
          //!More -------------------------------------------------------
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<_TodoMenuAction>(
                tooltip: "More",
                icon: const Icon(Icons.more_vert),
                onSelected: (action) async {
                  switch (action) {
                    case _TodoMenuAction.edit:
                      final updatedTodo = await showModalBottomSheet<TodoModel>(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        builder: (_) => AddTodoBottomSheet(task: task),
                      );

                      if (!context.mounted || updatedTodo == null) return;
                      context.read<TodosCubit>().updateTodo(projectId: projectId, todo: updatedTodo);

                      break;

                    case _TodoMenuAction.delete:
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Delete Task"),
                          content: Text(
                            'Are you sure you want to delete this task?',
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
                      context.read<TodosCubit>().deleteTodo(projectId: projectId, todoId: task.id);
                      // Navigator.pop(context);
                      // context.read<TodosCubit>().getTodos(projectId);
                      break;
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: _TodoMenuAction.edit,
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined),
                        SizedBox(width: 12),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: _TodoMenuAction.delete,
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
              _PriorityChip(priority: task.priority.name),
            ],
          ),
          //!-------------------------------------------------------

          /*  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Delete',
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                onPressed: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Delete Task'),
                      content: const Text(
                        'Are you sure you want to delete this task?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (!context.mounted || shouldDelete != true) return;
                  context.read<TodosCubit>().deleteTodo(projectId: projectId, todoId: task.id);
                },
              ),
              IconButton(
                tooltip: 'Edit',
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.blue,
                ),
                onPressed: () async {
                  final updatedTodo = await showModalBottomSheet<TodoModel>(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (_) => AddTodoBottomSheet(task: task),
                  );
                  if (updatedTodo == null || !context.mounted) return;
                  context.read<TodosCubit>().updateTodo(projectId: projectId, todo: updatedTodo);
                },
              ),
            ],
          )*/
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (title.toLowerCase()) {
      case "done":
        color = Colors.green;
        break;

      case "pending":
        color = Colors.orange;
        break;

      default:
        color = Colors.blue;
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 4,
          backgroundColor: color,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({
    required this.priority,
  });

  final String priority;

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (priority.toLowerCase()) {
      case "high":
        color = Colors.red;
        break;

      case "medium":
        color = Colors.orange;
        break;

      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
