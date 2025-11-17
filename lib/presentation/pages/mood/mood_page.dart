import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/domain/models/mood.dart';
import 'package:star_book_refactory/domain/repository/mood_repository.dart';
import 'package:star_book_refactory/injection.dart';
import 'package:star_book_refactory/presentation/pages/mood/bloc/mood_bloc.dart';
import 'package:star_book_refactory/presentation/pages/mood/bloc/mood_event.dart';
import 'package:star_book_refactory/presentation/pages/mood/bloc/mood_state.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoodBloc(
        InjectorSetup.resolve<MoodRepository>(),
      )..add(LoadMoods()),

      child: const MoodView(),
    );
  }
}

/// Mood UI View
class MoodView extends StatelessWidget {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🌙 Mood Tracker')),

      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state.moods.isEmpty) {
            return const Center(
              child: Text('아직 등록된 기분이 없어요 😶', style: TextStyle(fontSize: 16)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.moods.length,
            itemBuilder: (context, index) {
              final mood = state.moods[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(mood.colorValue),
                    child: const Icon(Icons.mood, color: Colors.white),
                  ),
                  title: Text(
                    mood.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '등록일: ${mood.date.toString().split(" ").first}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            heroTag: 'addMood',
            onPressed: () {
              context.read<MoodBloc>().add(AddMood(
                Mood(
                  id: DateTime.now().toIso8601String(),
                  name: '기분 좋아요!',
                  colorValue: 0xFF6C63FF, // 파스텔 블루
                  date: DateTime.now(),
                ),
              ));
            },
            label: const Text('추가'),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
          FloatingActionButton.extended(
            heroTag: 'clearMoods',
            backgroundColor: Colors.redAccent,
            onPressed: () {
              context.read<MoodBloc>().add(ClearMoods());
            },
            label: const Text('전체삭제'),
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
