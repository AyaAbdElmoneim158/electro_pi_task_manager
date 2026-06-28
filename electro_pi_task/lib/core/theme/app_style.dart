import 'package:electro_pi_task/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'font_weight_helper.dart';

abstract class AppStyles {
  static TextStyle header = TextStyle(
    fontSize: 24,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.primary,
  );
}
