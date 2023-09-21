import 'package:trello_tasks_sync/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAll();
  Future<Task> getById(String id);
  Future<void> create(Task task);
  Future<void> update(Task task);
  Future<void> delete(String id);
}
