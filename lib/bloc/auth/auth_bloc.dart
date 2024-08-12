// auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthAuthenticated(user: userCredential.user!)); // Provide the authenticated user
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthAuthenticated(user: userCredential.user!)); // Provide the registered user
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString())); // Handle sign out errors
    }
  }
}
