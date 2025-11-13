import 'package:hive/hive.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:uuid/uuid.dart';

class JournalRepository {
  static const _boxName = 'journal_box';
  late Box<Journal> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(JournalAdapter());
    }
    _box = await Hive.openBox<Journal>(_boxName);
  }

  List<Journal> getAll() => _box.values.toList();

  Future<void> addJournal(String title, String content) async {
    final newJournal = Journal(
      id: const Uuid().v4(),
      title: title,
      content: content,
      date: DateTime.now(),
    );
    await _box.put(newJournal.id, newJournal);
  }

  Future<void> deleteJournal(String id) async {
    await _box.delete(id);
  }
}
