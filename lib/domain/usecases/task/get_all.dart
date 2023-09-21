import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:trello_tasks_sync/domain/repositories/task.dart';

class GetAllTasks {
  final TaskRepository repository;

  GetAllTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getAll();
  }
}
