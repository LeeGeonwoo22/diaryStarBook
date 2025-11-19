import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:star_book_refactory/presentation/pages/journal/bloc/journal_bloc.dart';
import 'package:star_book_refactory/presentation/pages/journal/bloc/journal_event.dart';

class JournalEditPage extends StatefulWidget {
  final Journal journal;
  const JournalEditPage({super.key, required this.journal});

  @override
  State<JournalEditPage> createState() => _JournalEditPageState();
}

class _JournalEditPageState extends State<JournalEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  Timer? _autoSaveTimer;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.journal.title);
    _contentController = TextEditingController(text: widget.journal.content);

    // 🕒 3초마다 임시저장
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _autoSave();
    });
  }

  void _autoSave() {
    if (_isSaving) return;
    _isSaving = true;

    final updated = widget.journal.copyWith(
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now(),
    );

    context.read<JournalBloc>().add(UpdateJournal(updated));

    Future.delayed(const Duration(milliseconds: 500), () {
      _isSaving = false;
    });
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveAndExit() {
    _autoSave();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 수정 ✏️'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAndExit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: '내용',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _isSaving ? '임시 저장 중...' : '자동 저장 완료 ✅',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
