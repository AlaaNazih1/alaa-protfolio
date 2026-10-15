import 'package:flutter/material.dart';

abstract final class AppColors {
  // Dark theme
  static const Color background = Color(0xFF191C1D);
  static const Color surface = Color(0xFF1E2223);
  static const Color surfaceHover = Color(0xFF252A2B);
  static const Color primary = Color(0xFF1551C7);
  static const Color primaryHover = Color(0xFF2468E8);
  static const Color accent = Color(0xFF38A8FF);
  static const Color textPrimary = Color(0xFFD9D7D2);
  static const Color textSecondary = Color(0xFFB5B1A9);
  static const Color textMuted = Color(0xFF858783);
  static const Color border = Color(0xFF35393A);

  // Light theme
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceHover = Color(0xFFF1F5F9);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  static const Color success = Color(0xFF22A66A);
  static const Color error = Color(0xFFE53935);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
}