import '../../../../domain/models/journal.dart';

class JournalState {
  final List<Journal> journals;
  final bool isLoading;

  JournalState({
    required this.journals,
    required this.isLoading,
  });

  factory JournalState.initial() => JournalState(
    journals: [],
    isLoading: false,
  );
}
