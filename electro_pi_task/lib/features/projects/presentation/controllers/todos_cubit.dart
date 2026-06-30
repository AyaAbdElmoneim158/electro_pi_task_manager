import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/data/repos/projects_repo.dart';
import 'package:electro_pi_task/features/projects/data/repos/todos_repo.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit(this._repository, this._projectRepository) : super(const TodosInitial());
  final TodosRepository _repository;
  final ProjectsRepository _projectRepository;

  List<ProjectModel> projects = [];
  String _searchQuery = '';
  ProjectStatus? currentFilter;
  List<TodoModel> allTodos = [];
  List<TodoModel> filteredTodos = [];
  bool? _showOnlyCompleted;

  Future<void> addTodo({required String projectId, required TodoModel todo}) async {
    try {
      emit(TodosLoading());
      await _repository.addTodo(projectId: projectId, todo: todo);
      final result = await _projectRepository.getProjects();

      result.fold(
        (failure) => emit(TodosError(failure.toString())),
        (projects) {
          emit(const TodosSuccess("Task added successfully"));
          emit(ProjectTodosLoaded(projects));
        },
      );
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> getProjects() async {
    try {
      emit(TodosLoading());
      final result = await _projectRepository.getProjects();

      result.fold(
        (failure) => emit(TodosError(failure.toString())),
        (projects) {
          this.projects = projects;
          _applyFilters();
        },
      );
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  // Future<void> getTodos(ProjectModel project) async {
  //   emit(TodosLoading());
  //   await Future.delayed(const Duration(seconds: 3));
  //   await getProjects();
  //   emit(TodosLoaded(project.todos));

  //   // try {
  //   //   emit(TodosLoading());
  //   //   final result = await _projectRepository.getProjects();

  //   //   result.fold(
  //   //     (failure) => emit(TodosError(failure.toString())),
  //   //     (projects) {
  //   //       projects = projects;
  //   //       _applyFilters();
  //   //     },
  //   //   );
  //   // } catch (e) {
  //   //   emit(TodosError(e.toString()));
  //   // }
  // }

  Future<void> getTodos(String projectId) async {
    emit(const TodosLoading());
    final result = await _repository.getTodos(projectId);
    result.fold(
      (failure) => emit(TodosError(failure.errorModel.message ?? AppStrings.unexpectedError)),
      (todos) {
        allTodos = todos;
        emit(TodosLoaded(allTodos));

        _applyFilters();
      },
    );
  }

  Future<void> updateTodo({required String projectId, required TodoModel todo}) async {
    emit(const TodosLoading());
    final result = await _repository.updateTodo(projectId: projectId, todo: todo);
    result.fold((failure) => emit(TodosError(failure.toString())), (_) {
      print("ui");
      getProjects();
      // emit(TodosLoaded(allTodos));
    });
  }

  Future<void> deleteTodo({required String projectId, required String todoId}) async {
    emit(const TodosLoading());
    final result = await _repository.deleteTodo(projectId: projectId, todoId: todoId);
    result.fold(
      (failure) => emit(TodosError(failure.toString())),
      (_) => getProjects(),
    );
  }

  Future<void> toggleTodo({required String projectId, required String todoId, required bool completed}) async {
    final result = await _repository.toggleTodoStatus(projectId: projectId, todoId: todoId, completed: completed);
    result.fold(
      (failure) => emit(TodosError(failure.toString())),
      (_) => getProjects(),
    );
  }

  void searchTodos(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterTodosByStatus(bool? isCompleted) {
    _showOnlyCompleted = isCompleted;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _showOnlyCompleted = null;
    _applyFilters();
  }

  void _applyFilters() {
    List<TodoModel> result = List.from(allTodos);
    if (_showOnlyCompleted != null) {
      result = result.where((todo) => todo.completed == _showOnlyCompleted).toList();
    }

    if (_searchQuery.trim().isNotEmpty) {
      final keyword = _searchQuery.toLowerCase();
      result = result.where((todo) {
        return todo.title.toLowerCase().contains(keyword);
      }).toList();
    }

    filteredTodos = result;
    emit(TodosLoaded(filteredTodos));
  }
}
