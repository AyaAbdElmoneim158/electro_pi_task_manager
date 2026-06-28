
import 'package:electro_pi_task/features/auth/data/models/user_model.dart';

abstract interface class AuthDataSource {
  Future<bool> login(UserModel user);
  Future<UserModel?> getUser();

}
