import 'package:electro_pi_task/core/constants/app_assets.dart';
import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/core/routing/app_routes.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LogoutCard extends StatelessWidget {
  const LogoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: context.colorScheme.error.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        leading: const Icon(Icons.logout_rounded, color: Colors.red),
        title: const Text(
          AppStrings.logout,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        onTap: () async {
          final shouldLogout = await _buildLogoutDialog(context);
          if (shouldLogout == true && context.mounted) {
            context.read<AuthCubit>().logout();
            if (!context.mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRouter, (route) => false);
          }
        },
      ),
    );
  }

  Future<bool?> _buildLogoutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: AspectRatio(aspectRatio: 1, child: SvgPicture.string(AppAssets.themedLogoutIllustration)),
                ),
                Text(
                  AppStrings.logout,
                  style: context.textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          content: Text(
            AppStrings.logoutConfirmation,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(AppStrings.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: FilledButton.styleFrom(backgroundColor: context.colorScheme.error
                      // .withOpacity(0.4),
                      ),
                  child: Text(
                    AppStrings.logout,
                    style: TextStyle(color: context.colorScheme.onError),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
