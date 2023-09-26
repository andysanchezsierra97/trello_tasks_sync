import 'package:trello_tasks_sync/domain/entities/card.dart';
import 'package:trello_tasks_sync/domain/repositories/trello.dart';

class GetCardsOnAList {
  final TrelloRepository repository;

  GetCardsOnAList(this.repository);

  Future<List<TCard>> call(String token, String boardId, String listId) async {
    return await repository.getCardsOnAList(token, boardId, listId);
  }
}
