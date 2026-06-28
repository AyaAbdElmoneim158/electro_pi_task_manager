import 'package:electro_pi_task/core/common/cubits/theme_cubit.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/core/routing/app_router.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/core/service_locator.dart';
import 'package:electro_pi_task/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectroPiTaskApp extends StatelessWidget {
  const ElectroPiTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
      ],
      child: Builder(
        builder: (context) {
          final themeMode = context.select((ThemeCubit cubit) => cubit.state);
          final isDark = themeMode == ThemeMode.dark;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            ),
            child: MaterialApp(
              title: AppStrings.appTitle,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              themeAnimationDuration: Duration.zero,
              themeAnimationCurve: Curves.linear,
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute: AppRoutes.splashRouter,
            ),
          );
        },
      ),
    );
  }
}
