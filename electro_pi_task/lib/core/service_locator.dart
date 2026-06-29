import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electro_pi_task/core/api/firebase_auth_service.dart';
import 'package:electro_pi_task/core/api/firebase_firestore_service.dart';
import 'package:electro_pi_task/core/common/cubits/theme_cubit.dart';
import 'package:electro_pi_task/core/utils/shared_preferences_service.dart';
import 'package:electro_pi_task/features/auth/data/repos/auth_repo.dart';
import 'package:electro_pi_task/features/auth/data/source/auth_data_source.dart';
import 'package:electro_pi_task/features/auth/data/source/auth_firebase_data_source.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerLazySingleton<ThemeCubit>(ThemeCubit.new);

  sl
    ..registerLazySingleton<SharedPreferencesService>(() => SharedPreferencesService.instance)
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<FirebaseAuthServices>(() => FirebaseAuthServicesImpl(sl<FirebaseAuth>()))
    ..registerLazySingleton<FirestoreServices>(() => FirestoreServicesImpl(sl<FirebaseFirestore>()));


  sl
    ..registerLazySingleton<AuthDataSource>(() => AuthFirebaseDataSource(sl(), sl(), sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dataSource: sl()))
    ..registerFactory<AuthCubit>(() => AuthCubit(sl()));
}
