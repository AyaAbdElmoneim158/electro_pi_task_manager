import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:flutter/material.dart';

Color statusColor(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.completed:
      return Colors.green;
    case ProjectStatus.inProgress:
      return Colors.blue;
    case ProjectStatus.pending:
      return Colors.orange;
  }
}

String status(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.completed:
      return 'Completed';
    case ProjectStatus.inProgress:
      return 'In Progress';
    case ProjectStatus.pending:
      return 'Pending';
  }
}


String priorityText(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.low:
      return "Low";
    case TaskPriority.medium:
      return "Medium";
    case TaskPriority.high:
      return "High";
  }
}
String projectStatusText(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.pending:
      return "Pending";
    case ProjectStatus.inProgress:
      return "In Progress";
    case ProjectStatus.completed:
      return "Completed";
  }
}

String taskStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return "Pending";
      case TaskStatus.inProgress:
        return "In Progress";
      case TaskStatus.done:
        return "Done";
    }
  }

