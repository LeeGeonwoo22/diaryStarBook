import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppSettings {
  // box 이름을 정의함
  static const _boxName = 'app_settings';

  // 앱이 첫 실행인지를 구분하기 위한 key 이름이다.
  static const _freshInstallKey = 'isFreshInstall';

  // 실제 데이터를 담는 hive Box 객체
  late Box _box;

  // 초기화 메서드 - box 열기
  Future<void> init() async {
    //
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    _box = await Hive.openBox(_boxName);
  }

  // 앱이 첫 실행인지 여부를 불러오기
  bool get isFreshInstall => _box.get(_freshInstallKey, defaultValue: true);

  // 앱이 첫 실행이 아닌 상태로 변경할때 호출함 isFreshInstall 값을 false로 바꿈
  set isFreshInstall(bool value) {
    _box.put(_freshInstallKey, value);
  }

  // 전체 AppSettings 데이터를 초기화합니다.
  Future<void> reset() async {
    await _box.clear();
  }
}