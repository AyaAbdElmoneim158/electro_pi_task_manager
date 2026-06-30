import 'package:electro_pi_task/features/projects/data/models/project_model.dart';

sealed class ProjectsState {
  const ProjectsState();
}

final class ProjectsInitial extends ProjectsState {
  const ProjectsInitial();
}

final class ProjectsLoading extends ProjectsState {
  const ProjectsLoading();
}

class ProjectsLoaded extends ProjectsState {
  final List<ProjectModel> projects;
  const ProjectsLoaded(this.projects);
}

final class ProjectsError extends ProjectsState {
  const ProjectsError(this.message);
  final String message;
}

final class ProjectsSuccess extends ProjectsState {
  const ProjectsSuccess(this.message);
  final String message;
}
