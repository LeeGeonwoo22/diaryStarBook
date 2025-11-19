import 'package:flutter/material.dart';
import 'package:star_book_refactory/injection.dart';
import 'package:star_book_refactory/core/app_settings.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/routes/app_router.dart';

class StarBookApp extends StatefulWidget {
  const StarBookApp({super.key});

  @override
  State<StarBookApp> createState() => _StarBookAppState();
}

class _StarBookAppState extends State<StarBookApp> {
  late ThemeMode _themeMode;
  final AppSettings _appSettings = InjectorSetup.resolve<AppSettings>();

  @override
  void initState() {
    super.initState();
    _themeMode = _appSettings.getThemeMode();
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      _appSettings.setThemeMode(_themeMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StarBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        // ✅ 테마 토글 콜백을 전역으로 넘기기 (SettingsPage 등에서 접근 가능)
        return InheritedThemeSwitcher(
          themeMode: _themeMode,
          toggleTheme: _toggleTheme,
          child: child!,
        );
      },
    );
  }
}

/// ✅ 전역 위젯 트리에서 테마 토글 함수 공유
class InheritedThemeSwitcher extends InheritedWidget {
  final ThemeMode themeMode;
  final VoidCallback toggleTheme;

  const InheritedThemeSwitcher({
    super.key,
    required super.child,
    required this.themeMode,
    required this.toggleTheme,
  });

  static InheritedThemeSwitcher of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedThemeSwitcher>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedThemeSwitcher oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
