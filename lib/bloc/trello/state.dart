part of 'bloc.dart';

abstract class TrelloState {}

class TrelloInitState extends TrelloState {}

class TrelloVerifiedState extends TrelloState {}

class TrelloLoadingState extends TrelloState {}

class TrelloErrorState extends TrelloState {
  final String error;

  TrelloErrorState({required this.error});
}

class TrelloBoardsLoadedState extends TrelloState {
  final List<Board> boards;

  TrelloBoardsLoadedState({required this.boards});
}

class TrelloListsLoadedState extends TrelloState {
  final List<TList> lists;

  TrelloListsLoadedState({required this.lists});
}

class TrelloCardsLoadedState extends TrelloState {
  final List<TCard> cards;

  TrelloCardsLoadedState({required this.cards});
}
