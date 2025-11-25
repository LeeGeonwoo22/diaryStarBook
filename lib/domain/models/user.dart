import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';  // 이것도 추가 필요

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? nickname;

  @HiveField(3)
  final String? profileImage;

  @HiveField(4)  // 누락된 필드 추가
  final DateTime createdAt;

  User({
    required this.uid,
    required this.email,
    this.nickname,
    this.profileImage,
    required this.createdAt,
  });

  // Firestore → User
  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      email: data['email'],
      nickname: data['nickname'],
      profileImage: data['profileImage'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // User → Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'nickname': nickname,
      'profileImage': profileImage,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}