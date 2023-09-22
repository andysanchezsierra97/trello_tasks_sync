import 'package:flutter/material.dart';
import 'package:trello_tasks_sync/domain/entities/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(task.title), subtitle: Text(task.description));
  }
}
