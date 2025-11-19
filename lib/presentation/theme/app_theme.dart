import 'package:flutter/material.dart';
import 'ultramarine_light.dart';
import 'ultramarine_dark.dart';

class AppTheme {
  static ThemeData get light => UltramarineLightTheme().theme;
  static ThemeData get dark => UltramarineDarkTheme().theme;
}
