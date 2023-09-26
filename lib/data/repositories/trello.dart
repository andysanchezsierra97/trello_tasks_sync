import 'package:trello_tasks_sync/data/datasources/trello.dart';
import 'package:trello_tasks_sync/domain/entities/list.dart';
import 'package:trello_tasks_sync/domain/repositories/trello.dart';
import 'package:trello_tasks_sync/domain/entities/board.dart';
import 'package:trello_tasks_sync/domain/entities/card.dart';

class TrelloRepositoryImpl implements TrelloRepository {
  final TrelloDatasource datasource;

  TrelloRepositoryImpl(this.datasource);

  @override
  Future<List<Board>> getAllBoards(String token) async {
    return await datasource.getAllBoards(token);
  }

  @override
  Future<List<TList>> getListsOnABoard(String token, String boardId) async {
    return await datasource.getListsOnABoard(token, boardId);
  }

  @override
  Future<List<TCard>> getCardsOnAList(
      String token, String boardId, String listId) async {
    return await datasource.getCardsOnAList(token, boardId, listId);
  }

  @override
  Future<bool> verifyToken(String token) async {
    return await datasource.verifyToken(token);
  }

  @override
  Future<void> setToken(String token, String trelloToken) async {
    await datasource.setToken(token, trelloToken);
  }
}
