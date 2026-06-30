import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/repos/projects_repo.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this._repository) : super(const ProjectsInitial());
  final ProjectsRepository _repository;
  List<ProjectModel> _projects = [];
  List<ProjectModel> _filteredProjects = [];

  ProjectStatus? currentFilter;
  String _searchQuery = '';

  Future<void> getProjects() async {
    try {
      emit(const ProjectsLoading());
      final result = await _repository.getProjects();

      result.fold(
        (failure) => emit(ProjectsError(failure.toString())),
        (projects) {
          _projects = projects;
          _applyFilters();
        },
      );
    } catch (e) {
      emit(ProjectsError(e.toString()));
    }
  }

  Future<void> refreshProjects() async => await getProjects();

  Future<void> addProject(ProjectModel project) async {
    emit(const ProjectsLoading());
    final result = await _repository.addProject(project);

    result.fold(
      (failure) => emit(ProjectsError(failure.toString())),
      (_) => getProjects(),
    );
  }

  Future<void> updateProject(ProjectModel project) async {
    emit(const ProjectsLoading());
    final result = await _repository.updateProject(project);

    result.fold(
      (failure) => emit(ProjectsError(failure.toString())),
      (_) => getProjects(),
    );
  }

  Future<void> deleteProject(String projectId) async {
    emit(const ProjectsLoading());
    final result = await _repository.deleteProject(projectId);

    result.fold(
      (failure) => emit(ProjectsError(failure.toString())),
      (_) => getProjects(),
    );
  }

  void searchProjects(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterProjects(ProjectStatus? status) {
    currentFilter = status;
    _applyFilters();
  }

  void clearFilters() {
    currentFilter = null;
    _searchQuery = '';
    _applyFilters();
  }

  void _applyFilters() {
    List<ProjectModel> result = List.from(_projects);

    if (currentFilter != null) {
      result = result.where((project) => project.status == currentFilter).toList();
    }

    if (_searchQuery.trim().isNotEmpty) {
      final keyword = _searchQuery.toLowerCase();
      result = result.where((project) {
        return project.title.toLowerCase().contains(keyword) ||
         project.description.toLowerCase().contains(keyword);
      }).toList();
    }

    _filteredProjects = result;
    emit(ProjectsLoaded(_filteredProjects));
  }
}
