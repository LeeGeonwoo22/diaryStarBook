import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/injection.dart';
import 'package:star_book_refactory/domain/repository/journal_repository.dart';
import 'bloc/journal_bloc.dart';
import 'bloc/journal_event.dart';
import 'screens/journal_view.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const JournalView();
  }
}
