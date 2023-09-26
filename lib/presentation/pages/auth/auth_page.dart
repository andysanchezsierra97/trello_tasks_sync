import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/user/bloc.dart';
import 'package:trello_tasks_sync/presentation/pages/auth/login_page.dart';
import 'package:trello_tasks_sync/presentation/pages/auth/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoginPage = true;

  void _togglePage() {
    setState(() {
      _isLoginPage = !_isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_isLoginPage ? 'Welcome Back' : 'Create an Account'),
          centerTitle: true,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          final error = state is AuthErrorState ? state.error : "";
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: _isLoginPage
                  ? LoginPage(
                      error: error,
                      togglePage: _togglePage,
                    )
                  : RegisterPage(
                      error: error,
                      togglePage: _togglePage,
                    ),
            );
          }
        }));
  }
}
