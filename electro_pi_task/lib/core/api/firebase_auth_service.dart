import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthServices {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<User?> loginWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<void> logout();
  Future<void> deleteAccount();
}

class FirebaseAuthServicesImpl implements FirebaseAuthServices {
  final FirebaseAuth _firebaseAuth;
  FirebaseAuthServicesImpl(this._firebaseAuth);

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser?.delete();
  }
}
