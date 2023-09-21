import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:trello_tasks_sync/domain/repositories/task.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<void> call(Task task) async {
    await repository.create(task);
  }
}
