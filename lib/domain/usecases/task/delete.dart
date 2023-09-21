import 'package:trello_tasks_sync/domain/repositories/task.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(String id) async {
    await repository.delete(id);
  }
}
