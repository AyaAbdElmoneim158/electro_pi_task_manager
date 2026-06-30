import 'package:electro_pi_task/core/utils/function_utils.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/todos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoFloatingActionButton extends StatelessWidget {
  const TodoFloatingActionButton({super.key, required this.project});
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final todo = await showModalBottomSheet<TodoModel>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => const AddTodoBottomSheet(),
        );

        if (!context.mounted || todo == null) return;
        context.read<TodosCubit>().addTodo(projectId: project.id, todo: todo);
      },
      icon: const Icon(Icons.add),
      label: const Text('Todo'),
    );
  }
}
class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key, this.task});
  final TodoModel? task;

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;

  late TaskStatus _status;
  late TaskPriority _priority;

  bool get isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.task?.title ?? '',
    );

    _status = widget.task?.status ?? TaskStatus.pending;
    _priority = widget.task?.priority ?? TaskPriority.medium;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  isEditing ? "Edit Task" : "Add New Task",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Task Title",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Enter task title",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Task title is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                "Status",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: TaskStatus.values.map((status) {
                  return ChoiceChip(
                    label: Text(taskStatusText(status)),
                    selected: _status == status,
                    onSelected: (_) {
                      setState(() => _status = status);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                "Priority",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: TaskPriority.values.map((priority) {
                  return ChoiceChip(
                    label: Text(priorityText(priority)),
                    selected: _priority == priority,
                    onSelected: (_) {
                      setState(() => _priority = priority);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: _submit,
                    child: Text(
                      isEditing ? "Save Changes" : "Add Task",
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.tonal(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      TodoModel(
        id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        status: _status,
        priority: _priority,
        completed: _status == TaskStatus.done,
      ),
    );
  }

  
}
