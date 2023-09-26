import 'package:trello_tasks_sync/domain/entities/list.dart';
import 'package:trello_tasks_sync/domain/repositories/trello.dart';

class GetListsOnABoard {
  final TrelloRepository repository;

  GetListsOnABoard(this.repository);

  Future<List<TList>> call(String token, String boardId) async {
    return await repository.getListsOnABoard(token, boardId);
  }
}
