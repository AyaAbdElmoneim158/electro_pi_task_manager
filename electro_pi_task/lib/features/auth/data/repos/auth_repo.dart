import 'package:dartz/dartz.dart';
import 'package:electro_pi_task/core/error/error_model.dart';
import 'package:electro_pi_task/core/error/failures.dart';
import 'package:electro_pi_task/features/auth/data/models/user_model.dart';
import 'package:electro_pi_task/features/auth/data/source/auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Either
abstract interface class AuthRepository {
  Future<Either<Failure, void>> login(UserModel user);
  Future<Either<Failure, UserModel?>> getUser();
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required AuthDataSource dataSource}) : _dataSource = dataSource;
  final AuthDataSource _dataSource;

  @override
  Future<Either<Failure, void>> login(UserModel user) async {
    try {
      await _dataSource.login(user);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(ErrorModel(message: e.toString())));
    } on CacheFailure catch (e) {
      return Left(CacheFailure(ErrorModel(message: e.toString())));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getUser() async {
    try {
      final user = await _dataSource.getUser();
      return Right(user);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(ErrorModel(message: e.message ?? e.toString())));
    } on CacheFailure catch (e) {
      return Left(CacheFailure(ErrorModel(message: e.errorModel.message)));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(message: e.toString())));
    }
  }
}
