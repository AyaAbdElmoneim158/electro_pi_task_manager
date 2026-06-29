// lib/features/auth/presentation/widgets/auth_app_bar.dart
import 'package:electro_pi_task/core/common/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [ThemeToggleButton()],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
