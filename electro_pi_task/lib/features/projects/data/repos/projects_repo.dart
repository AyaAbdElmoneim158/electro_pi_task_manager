import 'package:dartz/dartz.dart';
import 'package:electro_pi_task/core/error/failures.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';

abstract interface class ProjectsRepository {
  Future<Either<Failure,List<ProjectModel>>> getProjects();
  Future<Either<Failure,ProjectModel>> getProjectById(String projectId);
  Future<Either<Failure,void>> addProject(ProjectModel project);
  Future<Either<Failure,void>> updateProject(ProjectModel project);
  Future<Either<Failure,void>> deleteProject(String projectId);
}
