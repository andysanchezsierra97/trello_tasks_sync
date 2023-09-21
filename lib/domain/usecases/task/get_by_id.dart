import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:trello_tasks_sync/domain/repositories/task.dart';

class GetTaskById {
  final TaskRepository repository;

  GetTaskById(this.repository);

  Future<Task> call(String id) async {
    return await repository.getById(id);
  }
}
