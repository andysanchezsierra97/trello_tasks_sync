import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:trello_tasks_sync/domain/repositories/task.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) async {
    await repository.update(task);
  }
}
