import 'package:flutter/material.dart';
import 'package:star_book_refactory/app.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSwitcher = InheritedThemeSwitcher.of(context);
    final isDark = themeSwitcher.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ 설정'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: themeSwitcher.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Text(
          isDark ? '🌙 다크 모드 사용 중' : '☀️ 라이트 모드 사용 중',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
