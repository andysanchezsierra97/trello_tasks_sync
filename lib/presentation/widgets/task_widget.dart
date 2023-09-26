// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/domain/entities/task.dart';

import 'package:trello_tasks_sync/presentation/widgets/add_task_widget.dart';

class TaskWidget extends StatefulWidget {
  final String token;
  final Task task;

  const TaskWidget(this.task, {required this.token, super.key});

  @override
  _TaskWidget createState() => _TaskWidget();
}

class _TaskWidget extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    Task task = widget.task;
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      return ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(task.description),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Switch(
              activeColor: Colors.green,
              inactiveTrackColor: Colors.yellow.shade700,
              value: task.isCompleted,
              onChanged: (newValue) {
                taskBloc.add(UpdateTaskEvent(
                    token: widget.token,
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    isCompleted: newValue));
              },
            ),
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit'),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddTaskAlertDialog(
                              token: widget.token, task: task);
                        },
                      );
                    },
                  ),
                ),
                PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Delete'),
                    onTap: () {
                      taskBloc.add(
                          DeleteTaskEvent(token: widget.token, id: task.id));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ]));
    });
  }
}
