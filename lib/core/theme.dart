import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff23243f);
  static const Color secondary = Color(0xffd9d100);
  static const Color lightPrimary = Color(0xff383a5b);
}

class AppTheme {
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.primary,
    colorSchemeSeed: AppColors.primary,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary),
    cardColor: AppColors.lightPrimary,
    useMaterial3: true,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      bodySmall: TextStyle(color: Colors.white),
    ),
  );
}
