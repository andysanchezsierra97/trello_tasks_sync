import 'package:trello_tasks_sync/domain/repositories/user.dart';

class Register {
  final UserRepository repository;

  Register(this.repository);

  Future<String> call(String username, String password) async {
    return await repository.register(username, password);
  }
}
