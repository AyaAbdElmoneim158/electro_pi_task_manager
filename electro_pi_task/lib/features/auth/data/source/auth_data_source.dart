import 'package:electro_pi_task/features/auth/data/models/user_model.dart';

abstract interface class AuthDataSource {
  Future<void> register(UserModel user);
  Future<void> login(UserModel user);
  Future<void> logout();
  Future<UserModel?> getUser();
}
