import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:star_book_refactory/core/firebase_service.dart'; // 🔥 위 FirebaseService 활용

class FirebaseJournalService {
  final FirebaseService _firebaseService = FirebaseService();

  FirebaseFirestore get _db => _firebaseService.db;

  Future<void> addJournal(Journal journal) async {
    await _db.collection('journals').doc(journal.id).set(journal.toMap());
  }

  Future<void> deleteJournal(String id) async {
    await _db.collection('journals').doc(id).delete();
  }

  Future<List<Journal>> getAllJournals() async {
    final snapshot = await _db.collection('journals').get();
    return snapshot.docs.map((doc) => Journal.fromMap(doc.data())).toList();
  }
}
