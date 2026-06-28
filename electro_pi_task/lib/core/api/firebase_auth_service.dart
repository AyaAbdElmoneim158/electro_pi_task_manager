import 'package:electro_pi_task/core/error/server_exceptions.dart';
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
  FirebaseAuthServicesImpl({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthExceptions(e);
      return null;
    }
  }

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthExceptions(e);
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthExceptions(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthExceptions(e);
    }
  }
}
