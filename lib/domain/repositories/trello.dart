import 'package:trello_tasks_sync/domain/entities/board.dart';
import 'package:trello_tasks_sync/domain/entities/list.dart';
import 'package:trello_tasks_sync/domain/entities/card.dart';

abstract class TrelloRepository {
  Future<List<Board>> getAllBoards(String token);
  Future<List<TList>> getListsOnABoard(String token, String boardId);
  Future<List<TCard>> getCardsOnAList(
      String token, String boardId, String listId);
  Future<bool> verifyToken(String token);
  Future<void> setToken(String token, String trelloToken);
}
