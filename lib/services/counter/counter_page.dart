import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/services/counter/bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';
import 'bloc/counter_state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> CounterBloc(),
      child: Builder(
        builder: (context)
          {
            return
            Scaffold(
              appBar: AppBar(title: const Text('Count with bloc'),),
              body: Center(
                child: BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      return Text('Count :${state.count}', style: TextStyle(fontSize: 32),);
                    }),
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () => context.read<CounterBloc>().add(CounterIncremented()),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () => context.read<CounterBloc>().add(CounterDecremented()),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            );
          }

      ),
    );
  }
}
