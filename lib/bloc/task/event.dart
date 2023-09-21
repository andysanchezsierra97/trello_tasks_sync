import 'package:trello_tasks_sync/domain/entities/task.dart';

abstract class TaskEvent {}

class FetchTasksEvent extends TaskEvent {}

class FetchTaskEvent extends TaskEvent {
  final String id;

  FetchTaskEvent(this.id);
}

class CreateTaskEvent extends TaskEvent {
  final Task task;

  CreateTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent(this.id);
}
