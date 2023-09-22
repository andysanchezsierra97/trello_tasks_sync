part of 'bloc.dart';

// @immutable
abstract class TaskEvent {}

class FetchTasksEvent extends TaskEvent {}

// class FetchTaskEvent extends TaskEvent {
//   final String id;

//   FetchTaskEvent({required this.id});
// }

class CreateTaskEvent extends TaskEvent {
  final Task task;

  CreateTaskEvent({required this.task});
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  UpdateTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent({required this.id});
}
