// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/presentation/widgets/task_widget.dart';

class TaskListPage extends StatefulWidget {
  final String token;
  const TaskListPage({super.key, required this.token});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    super.initState();
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    taskBloc.add(FetchTasksEvent(token: widget.token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks List'),
        centerTitle: true,
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          final taskBloc = BlocProvider.of<TaskBloc>(context);
          if (state is TaskErrorState) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
            );
            taskBloc.add(FetchTasksEvent(token: widget.token));
          } else if (state is TaskOperationSuccessState) {
            Fluttertoast.showToast(
              msg: state.action,
              toastLength: Toast.LENGTH_SHORT,
              textColor: Colors.white,
            );
            taskBloc.add(FetchTasksEvent(token: widget.token));
          }
        },
        builder: (context, state) {
          // final logger = Logger();
          // logger.i(state);
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TasksLoadedState) {
            final tasks = state.tasks;
            if (tasks.isEmpty) {
              return const Center(child: Text("No tasks to show"));
            } else {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: task.isCompleted
                              ? Colors.teal.shade800
                              : Colors.yellow.shade300,
                        ),
                      ),
                      child: TaskWidget(task, token: widget.token));
                },
              );
            }
          }
          return Container();
        },
      ),
      floatingActionButton: null,
    );
  }
}
