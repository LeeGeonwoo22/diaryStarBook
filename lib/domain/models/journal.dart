import 'package:hive/hive.dart';

part 'journal.g.dart'; // build_runner가 자동 생성

@HiveType(typeId: 1)
class Journal {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String content;

  @HiveField(3)
  late DateTime date;

  // ✅ 단 하나의 생성자만 유지
  Journal({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  // ✅ Map → Journal 변환
  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  // ✅ Journal → Map 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }
}
