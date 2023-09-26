import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/user/bloc.dart';
import 'package:trello_tasks_sync/presentation/pages/tasks/tasks_list_page.dart';
import 'package:trello_tasks_sync/presentation/pages/tasks/trello_tasks_list_page.dart';
import 'package:trello_tasks_sync/presentation/widgets/add_task_widget.dart';
import 'package:trello_tasks_sync/presentation/widgets/bottom_app_bar_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is! AuthAuthenticatedState) {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        authBloc.add(LogoutEvent());
        return Container();
      } else {
        return Scaffold(
          appBar: AppBar(
              title: const Text('Tasks Manager'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    final authBloc = BlocProvider.of<AuthBloc>(context);
                    authBloc.add(LogoutEvent());
                  },
                ),
              ]),
          body: PageView(
            controller: pageController,
            children: <Widget>[
              Center(
                child: TaskListPage(token: state.token),
              ),
              Center(
                child: TrelloTaskListPage(token: state.token),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_selectedIndex == 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddTaskAlertDialog(
                      token: state.token,
                    );
                  },
                );
              }
            },
            backgroundColor: Colors.blueGrey[700],
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBarWidget(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
                pageController.jumpToPage(index);
              });
            },
          ),
        );
      }
    });
  }
}
