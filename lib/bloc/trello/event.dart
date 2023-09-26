part of 'bloc.dart';

// @immutable
abstract class TrelloEvent {}

class TrelloVerifyEvent extends TrelloEvent {
  final String token;

  TrelloVerifyEvent({required this.token});
}

class TrelloSetEvent extends TrelloEvent {
  final String token;
  final String trelloToken;

  TrelloSetEvent({required this.token, required this.trelloToken});
}

class FetchTrelloBoardEvent extends TrelloEvent {
  final String token;

  FetchTrelloBoardEvent({required this.token});
}

class FetchTrelloListsEvent extends TrelloEvent {
  final String token;
  final String boardId;

  FetchTrelloListsEvent({required this.token, required this.boardId});
}

class FetchTrelloCardsEvent extends TrelloEvent {
  final String token;
  final String boardId;
  final String listId;

  FetchTrelloCardsEvent(
      {required this.token, required this.boardId, required this.listId});
}
