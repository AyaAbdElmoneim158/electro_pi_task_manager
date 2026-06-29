import 'dart:convert';

import 'package:electro_pi_task/core/api/end_points.dart';
import 'package:electro_pi_task/core/error/cache_exception.dart';
import 'package:electro_pi_task/core/utils/shared_preferences_service.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_data_source.dart';

class ProjectsLocalDataSource implements ProjectsDataSource {
  const ProjectsLocalDataSource(this._sharedPreferencesService);
  final SharedPreferencesService _sharedPreferencesService;

  @override
  Future<List<ProjectModel>> getProjects() async {
    final json = _sharedPreferencesService.getDataString(key: StorageKeys.projectsKey);
    if (json == null || json.isEmpty) throw CacheException('No cached projects found.');
    final List<dynamic> decoded = jsonDecode(json);
    return decoded.map((e) => ProjectModel.fromJson(e)).toList();
  }

  Future<void> saveProjects(List<ProjectModel> projects) async {
    final json = jsonEncode(projects.map((e) => e.toJson()).toList());
    final success = await _sharedPreferencesService.saveData(
      key: StorageKeys.projectsKey,
      value: json,
    );

    if (!success) throw CacheException('Failed to cache projects.');
  }

  @override
  Future<ProjectModel> getProjectById(String projectId) async {
    final projects = await getProjects();

    return projects.firstWhere(
      (element) => element.id == projectId,
      orElse: () => throw CacheException('Project not found.'),
    );
  }

  @override
  Future<void> addProject(ProjectModel project) async {
    final projects = await getProjects();
    projects.add(project);
    await saveProjects(projects);
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    final projects = await getProjects();
    final index = projects.indexWhere((e) => e.id == project.id);
    if (index == -1) throw CacheException('Project not found.');
    projects[index] = project;
    await saveProjects(projects);
  }

  @override
  Future<void> deleteProject(String projectId) async {
    final projects = await getProjects();
    projects.removeWhere((e) => e.id == projectId);
    await saveProjects(projects);
  }
}
