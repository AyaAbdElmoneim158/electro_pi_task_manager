import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/features/auth/data/models/user_model.dart';
import 'package:electro_pi_task/features/auth/data/repos/auth_repo.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());
  final AuthRepository _authRepository;
  UserModel? user;

  Future<void> login(UserModel user) async {
    emit(AuthLoading());
    final result = await _authRepository.login(user);

    result.fold(
      (failure) => emit(AuthError(failure.errorModel.message!)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> checkAuthStatus() async {
    if (user != null) return;
    emit(AuthLoading());
    final result = await _authRepository.getUser();

    result.fold(
      (failure) => emit(AuthError(failure.errorModel.message ?? AppStrings.unexpectedError)),
      (fetchedUser) {
        if (fetchedUser == null) {
          emit(Unauthenticated());
        } else {
          user = fetchedUser;
          emit(AuthSuccess(fetchedUser));
        }
        print("fetchedUser: ${user?.name ?? "name"} | ${user?.email ?? "email"}");
      },
    );
  }

  Future<void> register(UserModel user) async {
    emit(AuthLoading());
    final result = await _authRepository.register(user);

    result.fold(
      (failure) => emit(AuthError(failure.errorModel.message ?? AppStrings.unexpectedError)),
      (_) => emit(AuthSuccess(user)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _authRepository.logout();

    result.fold(
      (failure) => emit(AuthError(failure.errorModel.message ?? AppStrings.unexpectedError)),
      (_) => emit(Unauthenticated()),
    );
  }
}
