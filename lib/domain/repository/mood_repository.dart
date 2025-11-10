import 'package:hive/hive.dart';
import 'package:star_book_refactory/domain/models/mood.dart';

class MoodRepository {
  static const _boxName = 'moodBox';
  late Box _box;
  Future<void> init() async{
    _box = await Hive.openBox(_boxName);
  }

  final List<Mood> _moods = [];

  List<Mood> getAllMoods() => List.unmodifiable(_moods);

  void addMood(Mood mood) {
    _moods.add(mood);
  }

  void removeMood(String id) {
    _moods.removeWhere((m) => m.id == id);
  }
}