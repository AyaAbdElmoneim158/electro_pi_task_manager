import 'package:electro_pi_task/core/error/cache_exception.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_local_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/todos_data_source.dart';

class TodosLocalDataSource extends ProjectsLocalDataSource implements TodosDataSource {
  const TodosLocalDataSource(super._sharedPreferencesService);

  @override
  Future<List<TodoModel>> getTodos(String projectId) async {
    final project = await super.getProjectById(projectId);
    return project.todos;
  }

  @override
  Future<void> addTodo({
    required String projectId,
    required TodoModel todo,
  }) async {
    final project = await super.getProjectById(projectId);
    project.todos.add(todo);
    await super.updateProject(project);
  }

  @override
  Future<void> updateTodo({required String projectId, required TodoModel todo}) async {
    final project = await super.getProjectById(projectId);
    final index = project.todos.indexWhere((e) => e.id == todo.id);
    if (index == -1) throw CacheException('Todo not found.');
    project.todos[index] = todo;
    await super.updateProject(project);
  }

  @override
  Future<void> deleteTodo({
    required String projectId,
    required String todoId,
  }) async {
    final project = await super.getProjectById(projectId);
    project.todos.removeWhere((e) => e.id == todoId);
    await super.updateProject(project);
  }

  @override
  Future<void> toggleTodoStatus({required String projectId, required String todoId, required bool completed}) async {
    final project = await super.getProjectById(projectId);
    final index = project.todos.indexWhere((e) => e.id == todoId);
    if (index == -1) throw CacheException('Todo not found.');
    project.todos[index] = project.todos[index].copyWith(completed: completed);
    await super.updateProject(project);
  }
}
