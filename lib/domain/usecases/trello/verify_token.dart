import 'package:trello_tasks_sync/domain/repositories/trello.dart';

class VerifyToken {
  final TrelloRepository repository;

  VerifyToken(this.repository);

  Future<bool> call(String token) async {
    return await repository.verifyToken(token);
  }
}
