import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electro_pi_task/core/api/firebase_auth_service.dart';
import 'package:electro_pi_task/core/api/firebase_firestore_service.dart';
import 'package:electro_pi_task/core/common/cubits/theme_cubit.dart';
import 'package:electro_pi_task/core/utils/shared_preferences_service.dart';
import 'package:electro_pi_task/features/auth/data/repos/auth_repo.dart';
import 'package:electro_pi_task/features/auth/data/source/auth_data_source.dart';
import 'package:electro_pi_task/features/auth/data/source/auth_firebase_data_source.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/projects/data/repos/projects_repo.dart';
import 'package:electro_pi_task/features/projects/data/repos/projects_repository_impl.dart';
import 'package:electro_pi_task/features/projects/data/repos/todos_repo.dart';
import 'package:electro_pi_task/features/projects/data/repos/todos_repository_impl.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_firebase_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_local_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/todos_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/todos_firebase_data_source.dart';
import 'package:electro_pi_task/features/projects/data/source/todos_local_data_source.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/todos_cubit.dart';
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

  sl
    ..registerLazySingleton<ProjectsDataSource>(() => ProjectsFirebaseDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()))
    ..registerLazySingleton<ProjectsFirebaseDataSource>(() => ProjectsFirebaseDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()))
    ..registerLazySingleton<ProjectsLocalDataSource>(() => ProjectsLocalDataSource(sl<SharedPreferencesService>()))
    ..registerLazySingleton<ProjectsRepository>(() => ProjectsRepositoryImpl(sl<ProjectsFirebaseDataSource>(), sl<ProjectsLocalDataSource>()))
    ..registerFactory<ProjectsCubit>(() => ProjectsCubit(sl()));

  sl
    ..registerLazySingleton<TodosDataSource>(() => TodosFirebaseDataSource(sl(), sl()))
    ..registerLazySingleton<TodosFirebaseDataSource>(() => TodosFirebaseDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()))
    ..registerLazySingleton<TodosLocalDataSource>(() => TodosLocalDataSource(sl<SharedPreferencesService>()))
    ..registerLazySingleton<TodosRepository>(() => TodosRepositoryImpl(sl(), sl(), sl(), sl()))
    ..registerFactory<TodosCubit>(() => TodosCubit(sl(), sl()));
}
