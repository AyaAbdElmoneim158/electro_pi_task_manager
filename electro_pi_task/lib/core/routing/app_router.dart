import 'package:electro_pi_task/core/common/screens/error_404_screen.dart';
import 'package:electro_pi_task/core/common/screens/under_maintenance_screen.dart';
import 'package:electro_pi_task/core/common/screens/welcome_screen.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/core/service_locator.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/auth/presentation/views/screens/login_screen.dart';
import 'package:electro_pi_task/features/auth/presentation/views/screens/profile_screen.dart';
import 'package:electro_pi_task/features/auth/presentation/views/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    // final arguments = setting.arguments;
    switch (setting.name) {
      case AppRoutes.splashRouter:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: WelcomeScreen(),
          ),
        );

      case AppRoutes.underMaintenanceRouter:
        return MaterialPageRoute(
          builder: (context) => UnderMaintenanceScreen(),
        );

      case AppRoutes.error404Router:
        return MaterialPageRoute(
          builder: (context) => Error404Screen(),
        );

      case AppRoutes.loginRouter:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: LoginScreen(),
          ),
        );

      case AppRoutes.registerRouter:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: RegisterScreen(),
          ),
        );

      case AppRoutes.profileRouter:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<AuthCubit>()..checkAuthStatus(),
            child: ProfileScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
