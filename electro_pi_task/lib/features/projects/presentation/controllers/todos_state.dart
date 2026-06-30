import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';

sealed class TodosState {
  const TodosState();
}

final class TodosInitial extends TodosState {
  const TodosInitial();
}

final class TodosLoading extends TodosState {
  const TodosLoading();
}

class ProjectTodosLoaded extends TodosState {
  final List<ProjectModel> projects;
  const ProjectTodosLoaded(this.projects);
}

class TodosLoaded extends TodosState {
  final List<TodoModel> todos;
  const TodosLoaded(this.todos);
}

final class TodosError extends TodosState {
  const TodosError(this.message);

  final String message;
}

final class TodosSuccess extends TodosState {
  const TodosSuccess(this.message);
  final String message;
}
