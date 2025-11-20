import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

    // 📝 실시간 작성 상황 출력
    _titleController.addListener(() {
      print('📌 [제목 작성 중] ${_titleController.text}');
    });

    _contentController.addListener(() {
      print('✍️ [내용 작성 중] ${_contentController.text.length}자 작성됨');
      if (_contentController.text.isNotEmpty) {
        print('   내용 미리보기: ${_contentController.text.substring(0, _contentController.text.length > 50 ? 50 : _contentController.text.length)}${_contentController.text.length > 50 ? '...' : ''}');
      }
    });

    // 🕒 3초마다 임시저장
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _autoSave();
    });
  }

  void _autoSave() {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    final updated = widget.journal.copyWith(
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now(),
    );

    print('💾 [자동 저장 시작]');
    print('   제목: ${updated.title}');
    print('   내용 길이: ${updated.content.length}자');

    context.read<JournalBloc>().add(UpdateJournal(updated));

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        print('✅ [자동 저장 완료]\n');
      }
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
    print('🔒 [최종 저장 시작]');

    final updated = widget.journal.copyWith(
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now(),
    );

    print('   최종 제목: ${updated.title}');
    print('   최종 내용: ${updated.content}');
    print('   최종 저장 시각: ${updated.date}');

    // ✅ BLoC에 저장 요청
    context.read<JournalBloc>().add(UpdateJournal(updated));

    print('✅ [최종 저장 완료 - 이전 페이지로 이동]\n');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ 일기가 저장되었습니다!')),
    );

    // ✅ updated를 반환하면서 뒤로가기
    context.pop(updated);
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
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
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
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _isSaving ? '💾 임시 저장 중...' : '✅ 자동 저장 완료',
              style: TextStyle(
                fontSize: 12,
                color: _isSaving ? Colors.orange : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}