import 'package:electro_pi_task/core/theme/app_style.dart';
import 'package:electro_pi_task/core/utils/function_utils.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectFloatingActionButton extends StatelessWidget {
  const ProjectFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final project = await showModalBottomSheet<ProjectModel>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => const AddProjectBottomSheet(),
        );
        if (!context.mounted || project == null) return;
        context.read<ProjectsCubit>().addProject(project);
      },
      icon: const Icon(Icons.add),
      label: const Text('Project'),
    );
  }
}

class AddProjectBottomSheet extends StatefulWidget {
  const AddProjectBottomSheet({super.key, this.project});
  final ProjectModel? project;

  @override
  State<AddProjectBottomSheet> createState() => _AddProjectBottomSheetState();
}

class _AddProjectBottomSheetState extends State<AddProjectBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  ProjectStatus _status = ProjectStatus.pending;
  bool get isEditing => widget.project != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _title.text = widget.project!.title;
      _description.text = widget.project!.description;
      _status = widget.project!.status;
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
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
                  isEditing ? "Edit Project" : "Add New Project",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Project Title",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _description,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Required";
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
                children: ProjectStatus.values.map((status) {
                  return ChoiceChip(
                    label: Text(projectStatusText(status)),
                    selected: _status == status,
                    onSelected: (_) {
                      setState(() {
                        _status = status;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppStyles.authButtonStyle(),
                  onPressed: _submit,
                  child: Text(
                    isEditing ? "Update Project" : "Add Project",
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
      ProjectModel(
        id: widget.project?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        userId: widget.project?.userId ?? "CURRENT_USER_ID",
        title: _title.text.trim(),
        description: _description.text.trim(),
        status: _status,
        todos: widget.project?.todos ?? [],
      ),
    );
  }
}
