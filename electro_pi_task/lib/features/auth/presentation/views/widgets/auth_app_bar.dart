// lib/features/auth/presentation/widgets/auth_app_bar.dart
import 'package:electro_pi_task/core/common/widgets/theme_toggle_button.dart';
import 'package:electro_pi_task/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key, this.hasLeading = false});
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [ThemeToggleButton()],
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: hasLeading
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
