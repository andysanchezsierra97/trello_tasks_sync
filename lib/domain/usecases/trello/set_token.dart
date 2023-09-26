import 'package:trello_tasks_sync/domain/repositories/trello.dart';

class SetToken {
  final TrelloRepository repository;

  SetToken(this.repository);

  Future<void> call(String token, String trelloToken) async {
    await repository.setToken(token, trelloToken);
  }
}
