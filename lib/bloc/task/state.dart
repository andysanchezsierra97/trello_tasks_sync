import 'package:trello_tasks_sync/domain/entities/task.dart';

abstract class TaskState {}

class TaskLoadingState extends TaskState {}

class TasksLoadedState extends TaskState {
  final List<Task> tasks;

  TasksLoadedState(this.tasks);
}

class TaskLoadedState extends TaskState {
  final Task task;

  TaskLoadedState(this.task);
}

class TaskOperationSuccessState extends TaskState {
  final String action;

  TaskOperationSuccessState(this.action);
}

class TaskErrorState extends TaskState {
  final String error;

  TaskErrorState(this.error);
}
