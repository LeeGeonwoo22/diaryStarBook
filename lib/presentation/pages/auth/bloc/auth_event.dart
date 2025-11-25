import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];  // 비어있음
}

class AuthCheckRequested extends AuthEvent {}
class FacebookSignInRequested extends AuthEvent {}
class SignOutRequested extends AuthEvent {}

// 이메일 회원가입 이벤트
class EmailSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  EmailSignUpRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
// 예시: 이메일 로그인 이벤트
class EmailSignInRequested extends AuthEvent {
  final String email;
  final String password;

  EmailSignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];  // 비교할 필드 지정
}