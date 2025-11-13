// lib/services/firebase_journal_service.dart
// Firebase 초기화 및 Firestore 인스턴스 관리
// 원본 StarBook의 FirebaseService 구조와 동일하게 작성됨

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../firebase_options.dart';

class FirebaseService{
  late final FirebaseFirestore _firestore;

  Future<void> initialise()async{
    if(Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    _firestore = FirebaseFirestore.instance;
    print('[FirebaseService] Firebase initialized.');

  }

  FirebaseFirestore get db => _firestore;
}