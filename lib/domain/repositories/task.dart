import 'package:trello_tasks_sync/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAll(String token);
  Future<void> create(String token, String title, String description);
  Future<void> update(String token, String id, String title, String description,
      bool isCompleted);
  Future<void> delete(String token, String id);
}
