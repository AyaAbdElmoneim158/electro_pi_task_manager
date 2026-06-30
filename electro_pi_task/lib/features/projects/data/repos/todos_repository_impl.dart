// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:electro_pi_task/core/error/cache_exception.dart';
import 'package:electro_pi_task/core/error/error_model.dart';
import 'package:electro_pi_task/core/error/failures.dart';
import 'package:electro_pi_task/core/error/server_exceptions.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/data/repos/todos_repo.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_firebase_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/todos_firebase_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/todos_local_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodosRepositoryImpl  extends ProjectsFirebaseDataSource implements TodosRepository {
  TodosRepositoryImpl(this._remote, this._local, this._firestore, this._auth) : super(_auth, _firestore);
  final TodosFirebaseDataSource _remote;
  final TodosLocalDataSource _local;
  final FirebaseFirestore _firestore;//Todo: Best solution with relations
  final FirebaseAuth _auth;

  Future<void> _syncLocalCache() async {
    final projects = await super.getProjects();
    await _local.saveProjects(projects);
  }

  @override
  Future<Either<Failure, void>> addTodo({
    required String projectId,
    required TodoModel todo,
  }) async {
    try {
      await _remote.addTodo(projectId: projectId, todo: todo);
      await _syncLocalCache();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> toggleTodoStatus({
    required String projectId,
    required String todoId,
    required bool completed,
  }) async {
    try {
      await _remote.toggleTodoStatus(projectId: projectId, todoId: todoId, completed: completed);
      await _syncLocalCache();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo({
    required String projectId,
    required TodoModel todo,
  }) async {
    try {
      await _remote.updateTodo(projectId: projectId, todo: todo);
      await _syncLocalCache();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } on CacheFailure catch (e) {
      return Left(CacheFailure(handleCacheException(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo({
    required String projectId,
    required String todoId,
  }) async {
    try {
      await _remote.deleteTodo(projectId: projectId, todoId: todoId);
      await _syncLocalCache();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } on CacheFailure catch (e) {
      return Left(CacheFailure(handleCacheException(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> getTodos(String projectId) async {
    try {
      final project = await super.getProjectById(projectId);
      return Right(project.todos);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } catch (e) {
      try {
        final localProject = await _local.getProjectById(projectId);
        return Right(localProject.todos);
      } catch (cacheError) {
        return Left(CacheFailure(handleCacheException(cacheError)));
      }
    }
  }
}
