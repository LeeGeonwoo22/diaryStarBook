import 'package:flutter/material.dart';
import 'app_colors.dart';

class UltramarineDarkTheme {
  ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: Color(0xFF1E1E2C),
      background: Color(0xFF12121C),
      onPrimary: Colors.white,
      onSurface: Colors.white,
      error: AppColors.error,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E2C),
      foregroundColor: Colors.white,
      elevation: 0.5,
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E2C),
      selectedItemColor: AppColors.accent,
      unselectedItemColor: Colors.white60,
      elevation: 8,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.black,
    ),
  );
}
