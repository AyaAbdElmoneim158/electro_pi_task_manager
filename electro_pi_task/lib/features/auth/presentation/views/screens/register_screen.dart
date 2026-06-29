import 'package:electro_pi_task/core/common/widgets/default_screen_body.dart';
import 'package:electro_pi_task/core/constants/app_sizes.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_app_bar.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_navigation_text.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(hasLeading: true),
      body: DefaultScreenBody(
        children: [
          const AuthHeader(
            title: AppStrings.createAccount,
            subtitle: AppStrings.createAccountSubtitle,
          ),
          verticalSpace(AppSizes.spaceBtwSections * 3),
          const RegisterForm(),
          verticalSpace(AppSizes.defaultSpace * 8),
          AuthNavigationText(
            text: AppStrings.alreadyHaveAccount,
            actionText: AppStrings.loginButton,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
