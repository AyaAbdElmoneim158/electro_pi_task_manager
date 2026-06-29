enum TaskStatus { pending, inProgress, done }
enum TaskPriority { low, medium, high }

class TodoModel {
  final String id;
  final String title;
  final TaskStatus status;
  final TaskPriority priority;
  final bool completed;

  const TodoModel({
    required this.id,
    required this.title,
    required this.status,
    required this.priority,
    required this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: TaskStatus.values.byName(json['status'] as String? ?? 'pending'),
      priority: TaskPriority.values.byName(json['priority'] as String? ?? 'medium'),
      completed: json['completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status.name,
      'priority': priority.name,
      'completed': completed,
    };
  }

  TodoModel copyWith({
    String? id,
    String? title,
    TaskStatus? status,
    TaskPriority? priority,
    bool? completed,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
    );
  }
}
