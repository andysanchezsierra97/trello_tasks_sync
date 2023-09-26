import 'package:trello_tasks_sync/domain/repositories/trello.dart';
import 'package:trello_tasks_sync/domain/entities/board.dart';

class GetAllBoards {
  final TrelloRepository repository;

  GetAllBoards(this.repository);

  Future<List<Board>> call(String token) async {
    return await repository.getAllBoards(token);
  }
}
