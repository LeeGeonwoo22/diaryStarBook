import 'package:equatable/equatable.dart';

import '../../../../domain/models/journal.dart';

class JournalState extends Equatable{
  final List<Journal> journals;
  final bool isLoading;

  @override
  List<Object?> get props => [journals, isLoading];

  JournalState({
    required this.journals,
    required this.isLoading,
  });

  factory JournalState.initial() => JournalState(
    journals: [],
    isLoading: false,
  );

  // 일부 필드만 바꿀 때 유용
  JournalState copyWith({
    List<Journal>? journals,
    bool? isLoading,
  }) {
    return JournalState(
      journals: journals ?? this.journals,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
