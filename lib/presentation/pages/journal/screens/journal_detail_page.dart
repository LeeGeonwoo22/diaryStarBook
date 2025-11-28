import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_book_refactory/domain/models/journal.dart';

class JournalDetailPage extends StatefulWidget {
  final Journal journal;

  const JournalDetailPage({super.key, required this.journal});

  @override
  State<JournalDetailPage> createState() => _JournalDetailPageState();
}

class _JournalDetailPageState extends State<JournalDetailPage> {
  late Journal _currentJournal;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentJournal.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedJournal = await context.push<Journal>('/journal/${_currentJournal.id}/edit', extra: _currentJournal);
              if (updatedJournal != null) {
                setState((){
                  _currentJournal = updatedJournal;
                });
                print('🔄 [Detail 페이지 갱신됨]');
            }
            
            
    }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.journal.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "작성일: ${widget.journal.date.toString().split(' ').first}",
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.journal.content,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
