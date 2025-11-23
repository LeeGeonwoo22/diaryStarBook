import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/domain/repository/journal_repository.dart';
import 'package:star_book_refactory/presentation/pages/journal/bloc/journal_event.dart';

import 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalRepository repository;

  JournalBloc(this.repository) : super(JournalState.initial()) {
    print("🎯 JournalBloc 생성됨");
    on<LoadJournals>(_onLoad);
    on<AddJournal>(_onAdd);
    on<DeleteJournal>(_onDelete);
    on<UpdateJournal>(_onUpdate);
  }

  Future<void> _onLoad(
      LoadJournals event, Emitter<JournalState> emit) async {
    print("📥 LoadJournals 이벤트 처리 시작");
    final list = repository.getAll();
    print("📊 로드된 일기 수: ${list.length}");
    emit(state.copyWith(journals : list,isLoading: true));


    emit(state.copyWith(journals: list, isLoading: false));
    print("✅ 상태 업데이트 완료");
  }

  Future<void> _onAdd(
      AddJournal event, Emitter<JournalState> emit) async {
    print("➕ AddJournal 이벤트 처리 시작");
    print("제목: ${event.title}, 내용: ${event.content}");

    await repository.addJournal(event.title, event.content);
    print("✅ Repository addJournal 완료");

    // 즉시 목록 새로고침 (add 대신 직접 emit)
    final list = repository.getAll();
    print("📊 추가 후 일기 수: ${list.length}");

    emit(state.copyWith(journals: list, isLoading: false));
    print("✅ 상태 업데이트 완료");
  }

  Future<void> _onDelete(
      DeleteJournal event, Emitter<JournalState> emit) async {
        print("🗑️ DeleteJournal 이벤트 처리 시작");
        print("삭제할 ID: ${event.id}");

      await repository.deleteJournal(event.id);
        print("✅ Repository deleteJournal 완료");

    // 즉시 목록 새로고침
      final list = repository.getAll();
        print("📊 삭제 후 일기 수: ${list.length}");

      emit(JournalState(journals: list, isLoading: false));
        print("✅ 상태 업데이트 완료");
  }

  Future<void> _onUpdate(UpdateJournal event, Emitter<JournalState> emit) async {
    print("📝 UpdateJournal 이벤트 처리");
    await repository.updateJournal(event.updatedJournal);

    final list = repository.getAll();
    emit(state.copyWith(journals: list, isLoading: false));
  }
}