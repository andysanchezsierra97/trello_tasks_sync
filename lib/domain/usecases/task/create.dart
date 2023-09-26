import 'package:trello_tasks_sync/domain/repositories/task.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<void> call(String token, String title, String description) async {
    await repository.create(token, title, description);
  }
}
