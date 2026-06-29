import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/features/auth/data/models/user_model.dart';
import 'package:electro_pi_task/features/auth/data/repos/auth_repo.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());
  final AuthRepository _authRepository;

  Future<void> login(UserModel user) async {
    emit(AuthLoading());
    final result = await _authRepository.login(user);

    result.fold(
      (failure) => emit(AuthError(failure.errorModel.message!)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final result = await _authRepository.getUser();

    result.fold(
      (failure) => emit(AuthError(failure.errorModel.message ?? AppStrings.unexpectedError)),
      (user) => (user == null) ? emit(Unauthenticated()) : emit(AuthSuccess(user)),
    );
  }
}
