import 'package:electro_pi_task/core/common/widgets/theme_toggle_button.dart';
import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:electro_pi_task/core/constants/app_sizes.dart';
import 'package:electro_pi_task/core/constants/app_strings.dart';
import 'package:electro_pi_task/core/theme/app_style.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_state.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/logout_card.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/profile_avatar.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/profile_card.dart';
import 'package:electro_pi_task/features/auth/presentation/views/widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthCubit>().user;
    print("user-here: ${user?.name ?? "name"} | ${user?.email ?? "email"}");

    return Scaffold(
      body: Stack(
        children: [
          _buildBackPrimely(),
          SafeArea(
            child: Column(
              children: [
                verticalSpace(AppSizes.spaceBtwSections),
                _buildContentAtBackPrimely(context),
                verticalSpace(AppSizes.defaultSpace),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: AppStyles.roundedTopDecoration(context),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
                      child: Column(
                        children: [
                          verticalSpace(AppSizes.appBarHight * 1.3),
                          _buildUserInfo(),
                          verticalSpace(AppSizes.spaceBtwSections),
                          ProfileCard(
                            title: "Account",
                            children: [
                              ProfileListTile(icon: Icons.person_outline, title: "Edit Profile"),
                              Divider(height: 1, color: context.theme.hoverColor, endIndent: 18, indent: 18),
                              ProfileListTile(icon: Icons.lock_outline, title: "Change Password"),
                            ],
                          ),
                          verticalSpace(AppSizes.spaceBtwSections),
                          ProfileCard(
                            title: "Support",
                            children: [
                              ProfileListTile(icon: Icons.help_outline, title: "Help & FAQ"),
                              Divider(height: 1, color: context.theme.hoverColor, endIndent: 18, indent: 18),
                              ProfileListTile(icon: Icons.info_outline, title: "About App"),
                            ],
                          ),
                          // SizedBox(height: 20),
                          verticalSpace(AppSizes.spaceBtwSections),
                          LogoutCard(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ProfileAvatar(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final user = (state is AuthSuccess) ? state.user : null;
        if (state is AuthLoading) return const CircularProgressIndicator();
        return Column(
          children: [
            Text(
              user?.name ?? AppStrings.defaultName,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? AppStrings.defaultEmail,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContentAtBackPrimely(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.profile,
          style: context.textTheme.headlineLarge?.copyWith(
            color: context.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ThemeToggleButton(color: context.colorScheme.onPrimary),
        ),
      ],
    );
  }

  Widget _buildBackPrimely() {
    return Container(height: 360, decoration: AppStyles.primaryGradient);
  }
}
