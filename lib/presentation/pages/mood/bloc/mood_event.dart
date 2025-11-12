
import '../../../../domain/models/mood.dart';

abstract class MoodEvent {}

class LoadMoods extends MoodEvent{}

class AddMood extends MoodEvent {
  final Mood mood;
  AddMood(this.mood);
}

class RemoveMood extends MoodEvent {
  final String id;
  RemoveMood(this.id);
}

class ClearMoods extends MoodEvent {}

/// ✅ 완전 리셋 (모든 Hive 데이터 삭제)
class ResetHive extends MoodEvent {}