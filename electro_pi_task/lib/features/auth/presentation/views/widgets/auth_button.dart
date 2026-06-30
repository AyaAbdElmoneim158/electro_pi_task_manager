// lib/features/auth/presentation/widgets/auth_button.dart
import 'package:electro_pi_task/core/theme/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: AppStyles.authButtonStyle(),
      child: isLoading
          ? Transform.scale(
              scale: 1.2,
              child: CupertinoActivityIndicator(),
            )
          : Text(text),
    );
  }
}
