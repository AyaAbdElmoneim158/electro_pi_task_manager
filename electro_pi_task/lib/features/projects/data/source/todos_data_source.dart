import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';

abstract interface class TodosDataSource {
  Future<List<TodoModel>> getTodos(String projectId);
  Future<void> addTodo({required String projectId, required TodoModel todo});
  Future<void> updateTodo({required String projectId, required TodoModel todo});
  Future<void> deleteTodo({required String projectId, required String todoId});
  Future<void> toggleTodoStatus({required String projectId, required String todoId, required bool completed});
}
