import 'package:flutter/material.dart';

abstract class AppSizes {
  AppSizes._();
  static double xs = 4.0;
  static double sm = 8.0;
  static double md = 16.0;
  static double lg = 24.0;
  static double xl = 32.0;

  static double iconXs = 12.0;
  static double iconSm = 16.0;
  static double iconMd = 24.0;
  static double iconLg = 32.0;

  static double defaultSpace = 24.0;
  static double spaceBtwItems = 16.0;
  static double spaceBtwSections = 32.0;
  static double defaultPadding = 14.0;
  static double appBarHight = 56.0;

  static double borderRadiusSm = 4.0;
  static double borderRadiusMd = 8.0;
  static double borderRadiusLg = 12.0;
}

SizedBox verticalSpace(double height) => SizedBox(height: height);
SizedBox horizontalSpace(double width) => SizedBox(width: width);
