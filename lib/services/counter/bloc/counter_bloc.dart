import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/services/counter/bloc/counter_event.dart';
import 'package:star_book_refactory/services/counter/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    on<CounterIncremented>((event, emit) {
      emit(CounterState(state.count +1));
    });
    on<CounterDecremented>((event, emit) {
      emit(CounterState(state.count -1));
    });
  }
}