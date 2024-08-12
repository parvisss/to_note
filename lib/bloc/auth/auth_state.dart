// auth_state.dart
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user; // Include user information

  AuthAuthenticated({required this.user});
}

class AuthError extends AuthState {
  final String error; // Include error message

  AuthError(this.error);
}
