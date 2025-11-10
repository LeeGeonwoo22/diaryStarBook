import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/domain/repository/mood_repository.dart';
import 'package:star_book_refactory/presentation/pages/mood/bloc/mood_event.dart';
import 'package:star_book_refactory/presentation/pages/mood/bloc/mood_state.dart';

class MoodBloc extends Bloc<MoodEvent,MoodState> {
  final MoodRepository repository;

  MoodBloc(this.repository) : super(const MoodState()) {
    on<LoadMoods>((event,emit){
      emit(state.copyWith(moods: repository.getAllMoods()));
    });
    on<AddMood>((event, emit) {
      repository.addMood(event.mood);
      emit(state.copyWith(moods: repository.getAllMoods()));
    });

    on<RemoveMood>((event, emit) {
      repository.removeMood(event.id);
      emit(state.copyWith(moods: repository.getAllMoods()));
    });
  }
}