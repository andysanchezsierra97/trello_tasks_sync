part of 'bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final String token;

  AuthAuthenticatedState({required this.token});
}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}
