// lib/core/theme/text_theme_extension.dart
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  // Theme Accessors
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Text Styles - Headlines
  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  // Text Styles - Titles
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;

  // Text Styles - Body
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;

  // Text Styles - Labels
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;
}

extension SnackBarExtension on BuildContext {
  void showSnackBar({required String message, bool isError = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Theme.of(this).colorScheme.error : Theme.of(this).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
