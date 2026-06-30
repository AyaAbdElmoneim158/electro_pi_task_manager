
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:flutter/material.dart';

class ProjectFilterBottomSheet extends StatefulWidget {
  const ProjectFilterBottomSheet({
    super.key,
    this.selectedStatus,
  });

  final ProjectStatus? selectedStatus;

  @override
  State<ProjectFilterBottomSheet> createState() => _ProjectFilterBottomSheetState();
}

class _ProjectFilterBottomSheetState extends State<ProjectFilterBottomSheet> {
  ProjectStatus? selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Filter Projects',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            RadioListTile<ProjectStatus?>(
              value: null,
              groupValue: selectedStatus,
              title: const Text('All Projects'),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),
            RadioListTile<ProjectStatus?>(
              value: ProjectStatus.pending,
              groupValue: selectedStatus,
              title: const Text('Pending'),
              secondary: const Icon(
                Icons.schedule_rounded,
                color: Colors.orange,
              ),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),
            RadioListTile<ProjectStatus?>(
              value: ProjectStatus.inProgress,
              groupValue: selectedStatus,
              title: const Text('In Progress'),
              secondary: const Icon(
                Icons.timelapse_rounded,
                color: Colors.blue,
              ),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),
            RadioListTile<ProjectStatus?>(
              value: ProjectStatus.completed,
              groupValue: selectedStatus,
              title: const Text('Completed'),
              secondary: const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
              ),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, selectedStatus);
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
