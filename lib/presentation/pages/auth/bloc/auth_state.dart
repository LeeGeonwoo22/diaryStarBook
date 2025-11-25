import 'package:equatable/equatable.dart';

/// Bloc의 상태 변화를 정의
/// Equatable을 사용하면 같은 상태일 때 rebuild를 방지합니다.
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// 초기 상태 — 아직 로그인 시도 전
class AuthInitial extends AuthState {}

/// 로딩 상태 — 로그인/회원가입 처리 중
class AuthLoading extends AuthState {}

/// 로그인 성공 상태
class AuthAuthenticated extends AuthState {
  final String? userId;
  final String? email;

  AuthAuthenticated({this.userId, this.email});

  @override
  List<Object?> get props => [userId, email];
}

/// 로그아웃 상태 — 로그인 필요
class AuthUnauthenticated extends AuthState {}

/// 오류 상태 — 인증 실패나 예외 발생 시
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
