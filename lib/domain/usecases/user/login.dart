import 'package:trello_tasks_sync/domain/repositories/user.dart';

class Login {
  final UserRepository repository;

  Login(this.repository);

  Future<String> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
