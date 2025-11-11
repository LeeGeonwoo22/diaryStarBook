import 'package:hive/hive.dart';
import 'package:star_book_refactory/domain/models/mood.dart';

class MoodRepository {
  static const _boxName = 'moodBox';

  Box get _box => Hive.box(_boxName); // ✅ 이미 열린 Box 참조

  List<Mood> getAllMoods() {
    final moods = _box.values
        .map((e) => Mood.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return moods;
  }

  void addMood(Mood mood) {
    _box.put(mood.id, mood.toMap());
  }

  void removeMood(String id) {
    _box.delete(id);
  }
}
