import 'package:trello_tasks_sync/data/datasources/task.dart';
import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:trello_tasks_sync/domain/repositories/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource datasource;

  TaskRepositoryImpl(this.datasource);

  @override
  Future<List<Task>> getAll(String token) async {
    return await datasource.getAll(token);
  }

  @override
  Future<void> create(String token, String title, String description) async {
    await datasource.create(token, title, description);
  }

  @override
  Future<void> update(String token, String id, String title, String description,
      bool isCompleted) async {
    await datasource.update(token, id, title, description, isCompleted);
  }

  @override
  Future<void> delete(String token, String id) async {
    await datasource.delete(token, id);
  }
}
