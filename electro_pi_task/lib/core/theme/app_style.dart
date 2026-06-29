import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:electro_pi_task/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'font_weight_helper.dart';

abstract class AppStyles {
  static TextStyle header = TextStyle(
    fontSize: 24,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.primary,
  );

  static BoxDecoration roundedTopDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.scaffoldBackgroundColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
    );
  }

  static const BoxDecoration primaryGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.primary, AppColors.primary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      // color: context.theme.hoverColor, // cardBg,
      border: Border.all(color: context.theme.hoverColor, width: 1.5),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: context.colorScheme.onSecondary.withValues(alpha: 0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
