import 'package:electro_pi_task/core/common/screens/error_404_screen.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/core/routing/app_router.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ElectroPiTaskApp extends StatelessWidget {
  const ElectroPiTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        themeAnimationDuration: Duration.zero,
        themeAnimationCurve: Curves.linear,
        onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => const Error404Screen()),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes.splashRouter,
      ),
    );
  }
}
