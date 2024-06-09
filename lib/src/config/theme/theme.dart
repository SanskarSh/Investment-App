import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:investment_app/src/core/constant/color.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: AppColors.surface,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
    ),
    textTheme: buildTextTheme(),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
    ),
    textTheme: buildTextTheme(),
  );

  static TextTheme buildTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
