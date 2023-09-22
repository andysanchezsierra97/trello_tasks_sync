part of 'bloc.dart';

abstract class TaskState {}

class TaskLoadingState extends TaskState {}

class TasksLoadedState extends TaskState {
  final List<Task> tasks;

  TasksLoadedState({required this.tasks});
}

// class TaskLoadedState extends TaskState {
//   final Task task;

//   TaskLoadedState({required this.task});
// }

class TaskOperationSuccessState extends TaskState {
  final String action;

  TaskOperationSuccessState({required this.action});
}

class TaskErrorState extends TaskState {
  final String error;

  TaskErrorState({required this.error});
}
