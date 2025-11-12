import 'package:hive/hive.dart';

part 'journal.g.dart';

@HiveType(typeId: 1)
class Journal {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final DateTime date;

  Journal(this.id , this.title, this.content, this.date);

  // fromMap 생성자
  Journal.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        title = map['title'] as String,
        content = map['content'] as String,
        date = DateTime.parse(map['date'] as String);

  // toMap 메서드
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }
}