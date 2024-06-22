import 'package:flutter/material.dart';

class AppColors {
  final BuildContext context;

  // Light Theme Colors
  static const Color surface = Color.fromRGBO(245, 245, 245, 1);
  static const Color primary = Color.fromRGBO(0, 0, 0, 1);
  static const Color onPrimary = Color.fromRGBO(252, 252, 255, 1);
  static const Color secondary = Color.fromRGBO(250, 100, 110, 1);
  static const Color tertiary = Color.fromRGBO(160, 157, 141, 1);

  AppColors({required this.context});

  // Getters for theme-specific colors
  Color get surfaceColor => isDarkTheme(context) ? primary : surface;

  Color get primaryColor => isDarkTheme(context) ? surface : primary;

  Color get onPrimaryColor => onPrimary;

  Color get secondaryColor => secondary;

  Color get tertiaryColor => tertiary;

  static bool isDarkTheme(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }
}
