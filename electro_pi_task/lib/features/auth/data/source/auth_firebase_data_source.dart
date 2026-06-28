import 'package:electro_pi_task/core/api/end_points.dart';
import 'package:electro_pi_task/core/api/firebase_auth_service.dart';
import 'package:electro_pi_task/core/api/firebase_firestore_service.dart';
import 'package:electro_pi_task/core/utils/shared_preferences_service.dart';
import 'package:electro_pi_task/features/auth/data/models/user_model.dart';
import 'package:electro_pi_task/features/auth/data/source/auth_data_source.dart';

class AuthFirebaseDataSource implements AuthDataSource {
  AuthFirebaseDataSource({
    required this.firebaseAuthServices,
    required this.firestoreServices,
    required this.sharedPreferencesService,
  });

  final FirebaseAuthServices firebaseAuthServices;
  final FirestoreServices firestoreServices;
  final SharedPreferencesService sharedPreferencesService;

  @override
  Future<bool> login(UserModel user) async {
    final credential = await firebaseAuthServices.loginWithEmailAndPassword(user.email, user.password);
    if (credential == null) return false;
    final token = await credential.getIdToken();
    await sharedPreferencesService.saveData(key: StorageKeys.tokenKey, value: token);
    return true;
  }

  @override
  Future<UserModel?> getUser() async {
    final firebaseUser = firebaseAuthServices.currentUser;
    if (firebaseUser == null) return null;
    return firestoreServices.getDocument(
      path: Collection.usersPath(firebaseUser.uid),
      builder: (data, documentId) => UserModel.fromMap(data),
    );
  }
}
