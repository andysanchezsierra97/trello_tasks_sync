import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trello_tasks_sync/bloc/user/bloc.dart';

import 'package:trello_tasks_sync/presentation/pages/auth/auth_page.dart';
import 'package:trello_tasks_sync/presentation/pages/tasks/tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(GetCurrentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tasks Sync')),
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthAuthenticatedState) {
            return const TaskPage();
          } else {
            return const AuthPage();
          }
        }));
  }
}
