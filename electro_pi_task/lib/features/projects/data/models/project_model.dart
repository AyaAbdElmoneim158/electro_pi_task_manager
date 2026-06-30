import 'todo_model.dart';

enum ProjectStatus { pending, inProgress, completed }

class ProjectModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final ProjectStatus status;
  final List<TodoModel> todos;

  const ProjectModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
    required this.todos,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: ProjectStatus.values.byName(json['status'] as String),
      todos: (json['todos'] as List<dynamic>? ?? []).map((todo) => TodoModel.fromJson(todo as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'status': status.name,
      'todos': todos.map((todo) => todo.toJson()).toList(),
    };
  }

  ProjectModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    ProjectStatus? status,
    List<TodoModel>? todos,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      todos: todos ?? this.todos,
    );
  }

  int get completedTasksCount => todos.where((todo) => todo.completed).length;

  int get totalTasksCount => todos.length;

  /* static final List<ProjectModel> dummyData = [
    ProjectModel(
      id: 1,
      userId: 1,
      title: 'Mobile App Redesign',
      description: 'Redesign the UI and UX of the task manager mobile application.',
      status: ProjectStatus.inProgress,
      todos: [
        TodoModel(id: 1, title: 'Research user needs', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 2, title: 'Create wireframe', status: TaskStatus.inProgress, priority: TaskPriority.high, completed: false),
        TodoModel(id: 3, title: 'Design system setup', status: TaskStatus.done, priority: TaskPriority.medium, completed: true),
        TodoModel(id: 4, title: 'Implement login screens', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
      ],
    ),
    ProjectModel(
      id: 2,
      userId: 1,
      title: 'Marketing Website',
      description: 'Build a responsive marketing website for the company.',
      status: ProjectStatus.completed,
      todos: [
        TodoModel(id: 5, title: 'Create landing page design', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 6, title: 'Write website content', status: TaskStatus.done, priority: TaskPriority.medium, completed: true),
        TodoModel(id: 7, title: 'Add contact form', status: TaskStatus.done, priority: TaskPriority.low, completed: true),
      ],
    ),
    ProjectModel(
      id: 3,
      userId: 1,
      title: 'E-commerce Platform',
      description: 'Develop the core features for an online shopping platform.',
      status: ProjectStatus.inProgress,
      todos: [
        TodoModel(id: 8, title: 'Create product model', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 9, title: 'Build product listing screen', status: TaskStatus.inProgress, priority: TaskPriority.high, completed: false),
        TodoModel(id: 10, title: 'Add shopping cart', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
        TodoModel(id: 11, title: 'Implement checkout flow', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
      ],
    ),
    ProjectModel(
      id: 4,
      userId: 1,
      title: 'Customer Dashboard',
      description: 'Create an analytics dashboard for customers and administrators.',
      status: ProjectStatus.pending,
      todos: [
        TodoModel(id: 12, title: 'Define dashboard metrics', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
        TodoModel(id: 13, title: 'Create dashboard layout', status: TaskStatus.pending, priority: TaskPriority.medium, completed: false),
        TodoModel(id: 14, title: 'Build charts section', status: TaskStatus.pending, priority: TaskPriority.medium, completed: false),
      ],
    ),
    ProjectModel(
      id: 5,
      userId: 1,
      title: 'Task Manager App',
      description: 'Build a task management application with projects and tasks.',
      status: ProjectStatus.inProgress,
      todos: [
        TodoModel(id: 15, title: 'Create authentication flow', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 16, title: 'Create projects screen', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 17, title: 'Create project details screen', status: TaskStatus.inProgress, priority: TaskPriority.high, completed: false),
        TodoModel(id: 18, title: 'Add offline caching', status: TaskStatus.pending, priority: TaskPriority.medium, completed: false),
      ],
    ),
    ProjectModel(
      id: 6,
      userId: 1,
      title: 'Mobile App Redesign',
      description: 'Redesign the UI and UX of the task manager mobile application.',
      status: ProjectStatus.inProgress,
      todos: [
        TodoModel(id: 1, title: 'Research user needs', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 2, title: 'Create wireframe', status: TaskStatus.inProgress, priority: TaskPriority.high, completed: false),
        TodoModel(id: 3, title: 'Design system setup', status: TaskStatus.done, priority: TaskPriority.medium, completed: true),
        TodoModel(id: 4, title: 'Implement login screens', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
      ],
    ),
    ProjectModel(
      id: 7,
      userId: 1,
      title: 'Marketing Website',
      description: 'Build a responsive marketing website for the company.',
      status: ProjectStatus.completed,
      todos: [
        TodoModel(id: 5, title: 'Create landing page design', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 6, title: 'Write website content', status: TaskStatus.done, priority: TaskPriority.medium, completed: true),
        TodoModel(id: 7, title: 'Add contact form', status: TaskStatus.done, priority: TaskPriority.low, completed: true),
      ],
    ),
    ProjectModel(
      id: 8,
      userId: 1,
      title: 'E-commerce Platform',
      description: 'Develop the core features for an online shopping platform.',
      status: ProjectStatus.inProgress,
      todos: [
        TodoModel(id: 8, title: 'Create product model', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 9, title: 'Build product listing screen', status: TaskStatus.inProgress, priority: TaskPriority.high, completed: false),
        TodoModel(id: 10, title: 'Add shopping cart', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
        TodoModel(id: 11, title: 'Implement checkout flow', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
      ],
    ),
    ProjectModel(
      id: 9,
      userId: 1,
      title: 'Customer Dashboard',
      description: 'Create an analytics dashboard for customers and administrators.',
      status: ProjectStatus.pending,
      todos: [
        TodoModel(id: 12, title: 'Define dashboard metrics', status: TaskStatus.pending, priority: TaskPriority.high, completed: false),
        TodoModel(id: 13, title: 'Create dashboard layout', status: TaskStatus.pending, priority: TaskPriority.medium, completed: false),
        TodoModel(id: 14, title: 'Build charts section', status: TaskStatus.pending, priority: TaskPriority.medium, completed: false),
      ],
    ),
    ProjectModel(
      id: 10,
      userId: 1,
      title: 'Task Manager App',
      description: 'Build a task management application with projects and tasks.',
      status: ProjectStatus.inProgress,
      todos: [
        TodoModel(id: 15, title: 'Create authentication flow', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 16, title: 'Create projects screen', status: TaskStatus.done, priority: TaskPriority.high, completed: true),
        TodoModel(id: 17, title: 'Create project details screen', status: TaskStatus.inProgress, priority: TaskPriority.high, completed: false),
        TodoModel(id: 18, title: 'Add offline caching', status: TaskStatus.pending, priority: TaskPriority.medium, completed: false),
      ],
    ),
  ];*/
}
