
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