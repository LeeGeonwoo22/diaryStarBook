import 'package:flutter/material.dart';
import 'package:star_book_refactory/domain/models/journal.dart';

class JournalDetailPage extends StatelessWidget {
  final Journal journal;

  const JournalDetailPage({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(journal.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // 나중에 Step 2️⃣ 에서 수정 기능 추가 예정
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("수정 기능은 다음 단계에서 추가됩니다 ✏️")),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              journal.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "작성일: ${journal.date.toString().split(' ').first}",
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  journal.content,
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
