part of 'bloc.dart';

// @immutable
abstract class TaskEvent {}

class FetchTasksEvent extends TaskEvent {
  final String token;

  FetchTasksEvent({required this.token});
}

class CreateTaskEvent extends TaskEvent {
  final String token;
  final String title;
  final String description;

  CreateTaskEvent(
      {required this.token, required this.title, required this.description});
}

class UpdateTaskEvent extends TaskEvent {
  final String token;
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  UpdateTaskEvent(
      {required this.token,
      required this.id,
      required this.title,
      required this.description,
      required this.isCompleted});
}

class DeleteTaskEvent extends TaskEvent {
  final String token;
  final String id;

  DeleteTaskEvent({required this.token, required this.id});
}
