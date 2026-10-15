import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/app_colors.dart';

abstract final class AppTheme {
  static ThemeData dark() {
    final baseTheme = ThemeData.dark(useMaterial3: true);

    return baseTheme.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      dividerColor: AppColors.border,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
    );
  }

  static ThemeData light() {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
        bodyColor: AppColors.lightTextPrimary,
        displayColor: AppColors.lightTextPrimary,
      ),
      dividerColor: AppColors.lightBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
      ),
    );
  }
}
