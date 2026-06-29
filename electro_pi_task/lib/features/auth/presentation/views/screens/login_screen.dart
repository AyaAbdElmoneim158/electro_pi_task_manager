import 'package:electro_pi_task/core/common/widgets/default_screen_body.dart';
import 'package:electro_pi_task/core/constants/app_sizes.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_app_bar.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_navigation_text.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(),
      body: DefaultScreenBody(
        children: [
          const AuthHeader(
            title: AppStrings.loginTitle,
            subtitle: AppStrings.loginSubtitle,
          ),
          verticalSpace(AppSizes.spaceBtwSections * 3),
          const LoginForm(),
          verticalSpace(AppSizes.defaultSpace * 8),
          AuthNavigationText(
            text: AppStrings.noAccountText,
            actionText: AppStrings.signUpActionText,
            onTap: () => Navigator.pushNamed(context, AppRoutes.registerRouter),
          ),
        ],
      ),
    );
  }
}
