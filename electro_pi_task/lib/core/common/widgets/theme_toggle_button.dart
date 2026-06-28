import 'package:electro_pi_task/core/common/cubits/theme_cubit.dart';
import 'package:electro_pi_task/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (_, themeMode) {
        return IconButton(
          tooltip: 'Toggle Theme',
          icon: Icon(
            themeMode == ThemeMode.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: color ?? AppColors.primary,
          ),
          onPressed: () {
            context.read<ThemeCubit>().updateTheme(
                  themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
                );
          },
        );
      },
    );
  }
}
