import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:trello_tasks_sync/domain/usecases/user/login.dart';
import 'package:trello_tasks_sync/domain/usecases/user/register.dart';
import 'package:trello_tasks_sync/domain/usecases/user/get_current_user.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.login,
    required this.register,
    required this.getCurrentUser,
  }) : super(AuthInitialState()) {
    on<RegisterEvent>(_register);
    on<LoginEvent>(_login);
    on<LogoutEvent>(_logout);
    on<GetCurrentEvent>(_getCurrent);
  }

  void _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      const storage = FlutterSecureStorage();
      final token = await register(event.username, event.password);

      if (token.isNotEmpty) {
        await storage.write(key: 'token', value: token);
        emit(AuthAuthenticatedState(token: token));
      } else {
        emit(AuthErrorState(error: 'Failed to register, please try again'));
      }
    } catch (error) {
      emit(AuthErrorState(error: error.toString()));
    }
  }

  void _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      const storage = FlutterSecureStorage();
      final token = await login(event.username, event.password);
      if (token.isNotEmpty) {
        await storage.write(key: 'token', value: token);
        emit(AuthAuthenticatedState(token: token));
      } else {
        emit(AuthErrorState(error: 'Failed to login, please try again'));
      }
    } catch (error) {
      emit(AuthErrorState(error: error.toString()));
    }
  }

  void _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'token');
      emit(AuthInitialState());
    } catch (error) {
      emit(AuthErrorState(error: error.toString()));
    }
  }

  void _getCurrent(GetCurrentEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      if (token != null) {
        final user = await getCurrentUser(token);
        if (user != null) {
          emit(AuthAuthenticatedState(token: token));
        } else {
          await storage.delete(key: 'token');
          emit(AuthInitialState());
        }
      } else {
        emit(AuthInitialState());
      }
    } catch (error) {
      emit(AuthInitialState());
    }
  }
}
