class Mood {
  final String id;
  final String emoji;
  final String label;

  Mood({
    required this.id,
    required this.emoji,
    required this.label,
  });

  /// JSON or Map -> Mood
  factory Mood.fromMap(Map<String, dynamic> map) {
    return Mood(
      id: map['id'] ?? '',
      emoji: map['emoji'] ?? '',
      label: map['label'] ?? '',
    );
  }

  /// Mood -> Map (Hive 저장용)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emoji': emoji,
      'label': label,
    };
  }
}
