import 'package:trello_tasks_sync/data/datasources/task.dart';
import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:trello_tasks_sync/domain/repositories/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource datasource;

  TaskRepositoryImpl(this.datasource);

  @override
  Future<List<Task>> getAll() async {
    return await datasource.getAll();
  }

  @override
  Future<Task> getById(String id) async {
    return await datasource.getById(id);
  }

  @override
  Future<void> create(Task task) async {
    await datasource.create(task);
  }

  @override
  Future<void> update(Task task) async {
    await datasource.update(task);
  }

  @override
  Future<void> delete(String id) async {
    await datasource.delete(id);
  }
}
