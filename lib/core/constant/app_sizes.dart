import 'package:flutter/material.dart';

abstract final class AppSizes {
  // Layout
  static const double maxWidth = 1270;
  static const double navbarHeight = 78;

  // Spacing
  static const double spaceXS = 4;
  static const double spaceSM = 8;
  static const double spaceMD = 16;
  static const double spaceLG = 24;
  static const double spaceXL = 32;
  static const double spaceXXL = 48;
  static const double spaceXXXL = 80;

  // Radius
  static const double radiusSM = 8;
  static const double radiusMD = 12;
  static const double radiusLG = 20;
  static const double radiusXL = 28;
  

  // Responsive breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;

  // Hero
  static const double heroMinHeight = 810;

  // Reusable page padding
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 24);
}
