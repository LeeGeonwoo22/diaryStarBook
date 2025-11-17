import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/journal_bloc.dart';
import 'bloc/journal_state.dart';
import 'bloc/journal_event.dart';

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📔 Journal")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("추가 버튼 클릭");
          context.read<JournalBloc>().add(AddJournal(
            "샘플 제목",
            "샘플 내용 테스트",
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.journals.isEmpty) {
            return const Center(
              child: Text("작성된 일기가 없습니다."),
            );
          }

          return ListView(
            children: state.journals.map((j) {
              return ListTile(
                title: Text(j.title),
                subtitle: Text(j.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    print("삭제 버튼 클릭: ${j.id}");
                    context.read<JournalBloc>().add(DeleteJournal(j.id));
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
