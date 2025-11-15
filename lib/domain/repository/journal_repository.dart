import 'package:hive/hive.dart';
import 'package:star_book_refactory/core/firebase_service.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:star_book_refactory/injection.dart';
import 'package:uuid/uuid.dart';

class JournalRepository {
  static const _boxName = 'journal_box';
  late Box<Journal> _box;

  final FirebaseService _firebaseService = InjectorSetup.resolve<FirebaseService>();

  Future<void> init() async{
    // hive adaptor 등록
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(JournalAdapter());
    }
    // 로컬박스 오픈
    _box = await Hive.openBox<Journal>(_boxName);
  }
  List<Journal> getAll(){
    return _box.values.toList();
  }

  Future<void> addJournal(String title, String content) async{
    final id = const Uuid().v4();

    final journal = Journal(id: id, title: title, content: content, date: DateTime.now());
    // hive 저장
    await _box.put(id,journal);
    // firebase 저장
    await _firebaseService.db
          .collection("journals")
          .doc(id)
          .set(journal.toMap());
  }

  Future<void> deleteJournal(String id) async {
    await _box.delete(id);

    await _firebaseService.db
          .collection("journals")
          .doc(id)
          .delete();
  }
}