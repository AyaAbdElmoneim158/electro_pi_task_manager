import 'package:electro_pi_task/core/common/screens/error_404_screen.dart';
import 'package:electro_pi_task/core/common/screens/under_maintenance_screen.dart';
import 'package:electro_pi_task/core/common/screens/welcome_screen.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/core/service_locator.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/auth/presentation/views/screens/login_screen.dart';
import 'package:electro_pi_task/features/auth/presentation/views/screens/profile_screen.dart';
import 'package:electro_pi_task/features/auth/presentation/views/screens/register_screen.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/todos_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/views/screens/project_details_screen.dart';
import 'package:electro_pi_task/features/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    final arguments = setting.arguments;
    switch (setting.name) {
      case AppRoutes.splashRouter:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: WelcomeScreen(),
          ),
        );

      // case AppRoutes.underMaintenanceRouter:
      // return MaterialPageRoute(builder: (context) => UnderMaintenanceScreen());

      case AppRoutes.error404Router:
        return MaterialPageRoute(builder: (context) => Error404Screen());

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

      case AppRoutes.projectDetailsRouter:
        var args = arguments as List;
        var project = args[0] as ProjectModel;
        var userName = args[1] as String;

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<TodosCubit>()..getTodos(project.id),
            child: ProjectDetailsScreen(project,userName),
          ),
        );

      case AppRoutes.navBarRouter:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider<ProjectsCubit>(create: (_) => sl<ProjectsCubit>()..getProjects()),
            BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()..checkAuthStatus()),
          ], child: RootScreen()),
          // BlocProvider(
          //   create: (_) => sl<AuthCubit>()..checkAuthStatus(),
          //   child: ProfileScreen(),
          // ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
