import 'package:dartz/dartz.dart';
import 'package:electro_pi_task/core/error/cache_exception.dart';
import 'package:electro_pi_task/core/error/error_model.dart';
import 'package:electro_pi_task/core/error/failures.dart';
import 'package:electro_pi_task/core/error/server_exceptions.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/repos/projects_repo.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_local_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  const ProjectsRepositoryImpl(this._remote, this._local);
  final ProjectsDataSource _remote;
  final ProjectsLocalDataSource _local;

  @override
  Future<Either<Failure, List<ProjectModel>>> getProjects() async {
    try {
      final projects = await _remote.getProjects();
      await _local.saveProjects(projects);
      return Right(projects);
    } on FirebaseAuthException catch (e) {
      var errorModel = handleFirebaseAuthExceptions(e);
      return Left(ServerFailure(errorModel));
    } on CacheFailure catch (e) {
      return Left(CacheFailure(handleCacheException(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ProjectModel>> getProjectById(String projectId) async {
    try {
      final project = await _remote.getProjectById(projectId);
      return Right(project);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> addProject(ProjectModel project) async {
    try {
      await _remote.addProject(project);
      final projects = await _remote.getProjects();
      await _local.saveProjects(projects);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> updateProject(ProjectModel project) async {
    try {
      await _remote.updateProject(project);
      final projects = await _remote.getProjects();
      await _local.saveProjects(projects);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String projectId) async {
    try {
      await _remote.deleteProject(projectId);
      final projects = await _remote.getProjects();
      await _local.saveProjects(projects);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(handleFirebaseAuthExceptions(e)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }
}
