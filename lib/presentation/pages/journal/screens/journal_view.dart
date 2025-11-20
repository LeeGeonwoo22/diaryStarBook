import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:star_book_refactory/presentation/pages/journal/bloc/journal_bloc.dart';
import 'package:star_book_refactory/presentation/pages/journal/bloc/journal_state.dart';
import 'package:go_router/go_router.dart';


class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📔 나의 일기')),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.journals.isEmpty) {
            return const Center(child: Text('작성된 일기가 없습니다.'));
          }
          // ✅ 리스트 갱신 즉시 Bloc이 emit으로 다시 그립니다
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.journals.length,
            itemBuilder: (context, index) {
              final j = state.journals[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    j.title.isEmpty ? '(제목 없음)' : j.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // ✅ 제목 길면 한 줄로 자름
                  ),
                  subtitle: Text(
                    j.content.isEmpty
                        ? '내용이 없습니다.'
                        : '${j.content.substring(0, j.content.length > 40 ? 40 : j.content.length)}...',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  onTap: () {
                    // ✅ 수정페이지 이동 (저장 후 자동 갱신)
                    context.push('/journal/:id', extra: j);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // ✅ 새 일기 추가 페이지 이동
          final newJournal = Journal(
            id: DateTime.now().toIso8601String(),
            title: '',
            content: '',
            date: DateTime.now(),
          );
          context.push('edit', extra: newJournal);
        },
      ),
    );
  }
}
