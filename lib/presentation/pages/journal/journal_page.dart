import 'package:flutter/material.dart';
import 'package:star_book_refactory/domain/repository/journal_repository.dart';
import 'package:star_book_refactory/domain/models/journal.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final JournalRepository _repo = JournalRepository();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<Journal> _journals = [];

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    await _repo.init();
    setState(() {
      _journals = _repo.getAll();
    });
  }

  Future<void> _addJournal() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;
    await _repo.addJournal(_titleController.text, _contentController.text);
    setState(() {
      _journals = _repo.getAll();
    });
    _titleController.clear();
    _contentController.clear();
  }

  Future<void> _deleteJournal(String id) async {
    await _repo.deleteJournal(id);
    setState(() {
      _journals = _repo.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📔 Journal CRUD Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: '제목')),
            TextField(controller: _contentController, decoration: const InputDecoration(labelText: '내용')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addJournal, child: const Text('추가')),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _journals.length,
                itemBuilder: (context, index) {
                  final j = _journals[index];
                  return ListTile(
                    title: Text(j.title),
                    subtitle: Text(j.content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteJournal(j.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
