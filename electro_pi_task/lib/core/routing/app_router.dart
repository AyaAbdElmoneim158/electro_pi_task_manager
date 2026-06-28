import 'package:electro_pi_task/core/common/screens/error_404_screen.dart';
import 'package:electro_pi_task/core/common/screens/welcome_screen.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    // final arguments = setting.arguments;
    switch (setting.name) {
      case AppRoutes.splashRouter:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());

      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
