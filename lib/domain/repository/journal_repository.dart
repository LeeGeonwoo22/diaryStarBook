import 'package:hive/hive.dart';
import 'package:star_book_refactory/core/firebase_service.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:uuid/uuid.dart';

class JournalRepository {
  static const _boxName = 'journal_box';
  late Box<Journal> _box;

  /// FirebaseService를 외부에서 주입받음 (DI)
  final FirebaseService firebaseService;

  /// 생성자에서 firebaseService를 필수로 전달받음
  JournalRepository({required this.firebaseService});

  /// Hive Box 초기화
  Future<void> init() async {
    print("📦 JournalRepository init 시작");

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(JournalAdapter());
      print("✅ JournalAdapter 등록 완료");
    }

    _box = await Hive.openBox<Journal>(_boxName);
    print("✅ Hive Box 오픈 완료, 현재 항목 수: ${_box.length}");
  }

  /// 전체 일기 목록 조회
  List<Journal> getAll() {
    print("📋 전체 일기 조회: ${_box.length}개");
    return _box.values.toList();
  }

  /// 일기 추가
  Future<void> addJournal(String title, String content) async {
    final id = const Uuid().v4();
    print("➕ 일기 추가 시작 - ID: $id");

    final journal = Journal(
      id: id,
      title: title,
      content: content,
      date: DateTime.now(),
    );

    // Hive 저장
    await _box.put(id, journal);
    print("✅ Hive 저장 완료");

    // Firebase 동기화
    // try {
    //   await firebaseService.db
    //       .collection("journals")
    //       .doc(id)
    //       .set(journal.toMap());
    //   print("✅ Firebase 저장 완료");
    // } catch (e) {
    //   print("❌ Firebase 저장 실패: $e");
    // }
  }

  /// 일기 삭제
  Future<void> deleteJournal(String id) async {
    print("🗑️ 삭제 시작 - ID: $id");

    if (!_box.isOpen) {
      print("❌ Box가 닫혀있음");
      return;
    }

    if (!_box.containsKey(id)) {
      print("⚠️ 해당 ID가 Box에 존재하지 않음: $id");
      print("📦 현재 Box의 모든 키: ${_box.keys.toList()}");
      return;
    }

    await _box.delete(id);
    print("✅ Hive 삭제 완료, 남은 항목 수: ${_box.length}");

    // Firebase 삭제
    try {
      await firebaseService.db.collection("journals").doc(id).delete();
      print("✅ Firebase 삭제 완료");
    } catch (e) {
      print("❌ Firebase 삭제 실패: $e");
    }
  }
}
