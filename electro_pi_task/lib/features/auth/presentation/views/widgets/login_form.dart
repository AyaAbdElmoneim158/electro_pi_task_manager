import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:electro_pi_task/core/constants/app_sizes.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/core/utils/form_validators.dart';
import 'package:electro_pi_task/features/auth/data/models/user_model.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_state.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: FormValidators.emailValidator,
            decoration: const InputDecoration(
              hintText: AppStrings.emailHint,
              labelText: AppStrings.emailLabel,
            ),
          ),
          verticalSpace(AppSizes.spaceBtwItems),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            validator: FormValidators.passwordValidator,
            decoration: const InputDecoration(
              hintText: AppStrings.passwordHint,
              labelText: AppStrings.passwordLabel,
            ),
          ),
          verticalSpace(AppSizes.spaceBtwItems * 1.5),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushReplacementNamed(context, AppRoutes.navBarRouter);
              } else if (state is AuthError) {
                context.showSnackBar(message: state.message, isError: true);
              }
            },
            builder: (context, state) {
              return AuthButton(
                isLoading: state is AuthLoading,
                text: AppStrings.loginButton,
                onPressed: _login,
              );
            },
          ),
        ],
      ),
    );
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
          UserModel(
            name: 'null',
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }
}
