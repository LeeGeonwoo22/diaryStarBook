import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class AppSettings {
  static const _boxName = 'app_settings';
  static const _freshInstallKey = 'isFreshInstall';
  static const _themeModeKey = 'themeMode';

  late Box _box;

  /// 초기화 (Hive box 열기)
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    _box = await Hive.openBox(_boxName);
  }

  /// 첫 실행 여부
  bool get isFreshInstall => _box.get(_freshInstallKey, defaultValue: true);

  set isFreshInstall(bool value) {
    _box.put(_freshInstallKey, value);
  }

  /// ✅ 현재 테마 모드 불러오기
  ThemeMode getThemeMode() {
    final saved = _box.get(_themeModeKey, defaultValue: 'system');
    switch (saved) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// ✅ 테마 모드 저장
  void setThemeMode(ThemeMode mode) {
    final value = mode.toString().split('.').last; // ThemeMode.light → 'light'
    _box.put(_themeModeKey, value);
  }

  /// 전체 리셋
  Future<void> reset() async {
    await _box.clear();
  }
}
