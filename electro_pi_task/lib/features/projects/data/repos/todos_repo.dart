import 'package:dartz/dartz.dart';
import 'package:electro_pi_task/core/error/failures.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';

abstract interface class TodosRepository {
  Future<Either<Failure,List<TodoModel>>> getTodos(String projectId);
  Future<Either<Failure,void>> addTodo({required String projectId, required TodoModel todo});
  Future<Either<Failure,void>> updateTodo({required String projectId, required TodoModel todo});
  Future<Either<Failure,void>> deleteTodo({required String projectId, required String todoId});
  Future<Either<Failure,void>> toggleTodoStatus({required String projectId, required String todoId, required bool completed});
}
