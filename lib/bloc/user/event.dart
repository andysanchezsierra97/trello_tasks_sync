part of 'bloc.dart';

abstract class AuthEvent {}

class GetCurrentEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;

  RegisterEvent({required this.username, required this.password});
}
