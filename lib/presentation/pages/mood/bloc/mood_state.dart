import '../../../../domain/models/mood.dart';

class MoodState {
  final List<Mood> moods;
  final bool isLoading;

  const MoodState({
    this.moods = const [],
    this.isLoading = false,
});

  MoodState copyWith({
    List<Mood>? moods,
    bool? isLoading,
}) {
    return MoodState(
      moods: moods ?? this.moods,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}