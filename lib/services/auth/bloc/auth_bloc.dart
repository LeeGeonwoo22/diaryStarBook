import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book_refactory/domain/repository/auth_repository.dart';
import 'package:star_book_refactory/services/auth/bloc/auth_event.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheck);
    on<FacebookSignInRequested>(_onFacebookSignIn);
    on<SignOutRequested>(_onSignOut);
  }

  Future<void> _onAuthCheck(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(userId: user.uid, email: user.email));
    } else {
      emit(AuthUnauthenticated());
    }
  }


  Future<void> _onFacebookSignIn(
      FacebookSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // await _authRepository.signInWithFacebook();
      // emit(AuthAuthenticated());
      final user = await _authRepository.signInWithFacebook();
      emit(AuthAuthenticated(userId: user?.uid, email: user?.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(AuthUnauthenticated());
  }
}