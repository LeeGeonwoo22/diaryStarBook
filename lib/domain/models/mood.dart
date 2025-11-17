import 'package:hive/hive.dart';

part 'mood.g.dart'; // 🔥 반드시 추가 — 자동 생성 파일

@HiveType(typeId: 0) // typeId는 모델마다 고유해야 합니다 (예: 0은 Mood, 1은 Journal)
class Mood {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int colorValue; // 예: 색상 코드 저장용 (0xFFAA00FF)

  @HiveField(3)
  late DateTime date;

  Mood({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.date,
  });

  /// ✅ Map → Mood
  factory Mood.fromMap(Map<String, dynamic> map) {
    return Mood(
      id: map['id'] as String,
      name: map['name'] as String,
      colorValue: map['colorValue'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }

  /// ✅ Mood → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'colorValue': colorValue,
      'date': date.toIso8601String(),
    };
  }
}
