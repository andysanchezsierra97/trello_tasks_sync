import 'package:trello_tasks_sync/domain/repositories/user.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<String?> call(String token) async {
    return await repository.getCurrentUser(token);
  }
}
