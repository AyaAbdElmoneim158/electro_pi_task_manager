import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:flutter/material.dart';

class AuthNavigationText extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthNavigationText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: context.bodyMedium),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: context.bodyMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
