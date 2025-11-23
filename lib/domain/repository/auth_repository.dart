import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class AuthRepository {
  Future<User?> signInWithFacebook();
  Future<void> signOut();
}

class  AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.userChanges();

  Future<User?> signInWithFacebook() async{
    try{
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {

        final AccessToken accessToken = result.accessToken!;
        final facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);
        final userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);

        return userCredential.user;
      } else {
        throw Exception('Facebook 로그인 실패: ${result.message}');

      }
    }catch(e) {
      throw Exception('Facebook 로그인 오류 : $e');
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
    await FacebookAuth.instance.logOut();
  }

  User? get currentUser => _auth.currentUser;
}