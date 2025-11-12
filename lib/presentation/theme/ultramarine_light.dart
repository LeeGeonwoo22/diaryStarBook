import 'package:flutter/material.dart';

class UltramarineLightTheme {
  ThemeData get theme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );
}
