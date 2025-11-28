import 'package:cloud_firestore/cloud_firestore.dart';  // 추가!
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class AuthRepository {
  Future<User?> signInWithFacebook();
  Future<User?> signInWithEmail(String email, String password);
  Future<User?> signUpWithEmail(String email, String password);
  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  // 추가!

  Stream<User?> get userChanges => _auth.userChanges();

  @override
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken.token);
        final userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);

        final user = userCredential.user;

        // Firestore에 사용자 정보 저장 (없으면 생성)
        if (user != null) {
          await _createOrUpdateUser(user);
        }

        return user;
      } else {
        throw Exception('Facebook 로그인 실패: ${result.message}');
      }
    } catch (e) {
      throw Exception('Facebook 로그인 오류 : $e');
    }
  }

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      // 로그인 (signInWithEmailAndPassword 사용)
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('이메일 로그인 실패: $e');
    }
  }

  @override
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      // 회원가입
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      // Firestore에 사용자 정보 저장
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'nickname': null,
          'profileImage': null,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('✅ Firestore에 유저 저장 완료: ${user.uid}');
      }

      return user;
    } catch (e) {
      print('❌ 회원가입 실패: $e');
      throw Exception('회원가입 실패: $e');
    }
  }

  @override
  @override
  Future<void> signOut() async {
    try {
      // Facebook 로그인 상태 확인 후 로그아웃
      final accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        await FacebookAuth.instance.logOut();
      }
    } catch (e) {
      print('Facebook 로그아웃 스킵: $e');
    }

    // Firebase Auth 로그아웃 (항상 실행)
    await _auth.signOut();
    print('✅ 로그아웃 완료');
  }

  User? get currentUser => _auth.currentUser;

  // Firestore에 사용자 생성 또는 업데이트 (Facebook 로그인용)
  Future<void> _createOrUpdateUser(User user) async {
    final docRef = _firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      // 새 사용자면 생성
      await docRef.set({
        'uid': user.uid,
        'email': user.email,
        'nickname': user.displayName,
        'profileImage': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('✅ Firestore에 새 유저 생성: ${user.uid}');
    } else {
      // 기존 사용자면 마지막 로그인 시간 업데이트
      await docRef.update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
      print('✅ 마지막 로그인 시간 업데이트: ${user.uid}');
    }
  }
}