import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/domain/models/mood.dart';
import 'package:star_book_refactory/domain/repository/mood_repository.dart';
import 'package:star_book_refactory/presentation/pages/mood/bloc/mood_bloc.dart';
import 'package:star_book_refactory/presentation/pages/mood/bloc/mood_event.dart';

import 'bloc/mood_state.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoodBloc(MoodRepository())..add(LoadMoods()),
      child: Builder(
        builder: (context){
          return Scaffold(
            appBar: AppBar(title: const Text('Mood Tracker 🌙')),
            body: BlocBuilder<MoodBloc, MoodState>(
                builder: (context, state) {
                  if(state.moods.isEmpty) {
                    return const Center(child: Text('아직 등록된 기분이 없어요  😶'),);
                  }
                  return ListView.builder(
                    itemCount: state.moods.length,
                    itemBuilder: (context,index) {
                      final mood = state.moods[index];
                      return ListTile(
                        leading: Text(mood.emoji, style: const TextStyle(fontSize: 24)),
                        title: Text(mood.label),
                      );
                    },
                  );
                }
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              children: [
                FloatingActionButton(
                  onPressed: (){
                    context.read<MoodBloc>().add(
                        AddMood(Mood(
                          id: DateTime.now().toString(),
                          emoji: '😊',
                          label: '좋아요!',
                        ))
                    );
                  },
                  child:
                  const Icon(Icons.add)
                  ,),
                FloatingActionButton(
                  heroTag: 'clear',
                  backgroundColor: Colors.redAccent,
                  onPressed: () {
                    context.read<MoodBloc>().add(ClearMoods());
                  },
                  child: const Icon(Icons.delete_forever),
                ),
              ],
            ),

          );
        },
      ),
    );
  }
}