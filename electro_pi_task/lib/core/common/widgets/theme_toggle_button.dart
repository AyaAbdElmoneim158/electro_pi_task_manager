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
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
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
              ),
            ),
          ),
        );
      },
    );
  }
}
/*
                                )
Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(18),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(18),
                                    onTap: onFilter,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: ThemeToggleButton(),
                                      // const Icon(Icons.tune_rounded),
                                    ),
                                  ),
                                )
 */
