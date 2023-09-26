import 'package:trello_tasks_sync/domain/repositories/task.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(String token, String id, String title, String description,
      bool isCompleted) async {
    await repository.update(token, id, title, description, isCompleted);
  }
}
