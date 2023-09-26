import 'package:trello_tasks_sync/data/datasources/user.dart';
import 'package:trello_tasks_sync/domain/repositories/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<String> register(String username, String password) async {
    return await datasource.register(username, password);
  }

  @override
  Future<String> login(String username, String password) async {
    return await datasource.login(username, password);
  }

  @override
  Future<String?> getCurrentUser(String token) async {
    return await datasource.getCurrentUser(token);
  }
}
