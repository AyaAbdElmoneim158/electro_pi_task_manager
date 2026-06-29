import 'package:electro_pi_task/core/constants/app_assets.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_state.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/auth_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await context.read<AuthCubit>().checkAuthStatus();
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      Navigator.pushReplacementNamed(context, AppRoutes.profileRouter);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginRouter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: AspectRatio(aspectRatio: 1, child: SvgPicture.string(AppAssets.themedWelcomeIllustration)),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Hello and Welcome",
                description: "We're setting things up for you. This will only take a moment.",
                button: Transform.scale(
                  scale: 1.8,
                  child: CupertinoActivityIndicator(),
                ),
                press: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            button ??
                ElevatedButton(
                  onPressed: press,
                  child: Text(btnText ?? AppStrings.retry),
                ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
