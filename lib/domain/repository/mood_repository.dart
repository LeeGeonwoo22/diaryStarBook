import 'package:hive/hive.dart';
import 'package:star_book_refactory/domain/models/mood.dart';

class MoodRepository {
  static const _boxName = 'moodBox';
  late Box _box;

  /// Hive 초기화
  Future<void> init() async {
    print("🌙 MoodRepository 초기화 시작");

    if (!Hive.isBoxOpen(_boxName)) {
      // MoodAdapter 등록 여부 확인
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(MoodAdapter());
        print("✅ MoodAdapter 등록 완료");
      }

      _box = await Hive.openBox(_boxName);
      print("✅ Mood Box 열림 (${_box.length}개 데이터)");
    } else {
      _box = Hive.box(_boxName);
      print("📦 이미 열려있는 Mood Box 재사용");
    }
  }

  /// 전체 Mood 데이터 가져오기
  List<Mood> getAllMoods() {
    print("📋 전체 Mood 조회 (${_box.length}개)");
    final moods = _box.values
        .map((e) => Mood.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return moods;
  }

  /// Mood 추가
  void addMood(Mood mood) {
    _box.put(mood.id, mood.toMap());
    print("➕ Mood 추가 완료 (${mood.id})");
  }

  /// Mood 삭제
  void removeMood(String id) {
    _box.delete(id);
    print("🗑️ Mood 삭제 완료 ($id)");
  }

  /// 모든 Mood 초기화
  Future<void> clearAllMoods() async {
    await _box.clear();
    print("⚠️ 모든 Mood 데이터 삭제 완료");
  }

  /// Hive 전체 데이터 초기화 (앱 전체 리셋용)
  Future<void> resetHive() async {
    await Hive.deleteFromDisk();
    print("💣 Hive 전체 데이터 삭제 완료");
  }
}
