import 'package:electro_pi_task/features/projects/data/models/project_model.dart';

abstract interface class ProjectsDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> getProjectById(String projectId);
  Future<void> addProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project);
  Future<void> deleteProject(String projectId);
}
