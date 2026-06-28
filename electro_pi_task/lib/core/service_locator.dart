import 'package:electro_pi_task/core/common/cubits/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerLazySingleton<ThemeCubit>(ThemeCubit.new);

}
