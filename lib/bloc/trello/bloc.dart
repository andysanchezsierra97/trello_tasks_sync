import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trello_tasks_sync/domain/entities/board.dart';
import 'package:trello_tasks_sync/domain/entities/card.dart';
import 'package:trello_tasks_sync/domain/entities/list.dart';

import 'package:trello_tasks_sync/domain/usecases/trello/get_all_boards.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/get_cards_ona_list.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/get_lists_ona_board.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/verify_token.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/set_token.dart';

part 'event.dart';
part 'state.dart';

class TrelloBloc extends Bloc<TrelloEvent, TrelloState> {
  final GetAllBoards getAllBoards;
  final GetListsOnABoard getListsOnABoard;
  final GetCardsOnAList getCardsOnAList;
  final VerifyToken verifyToken;
  final SetToken setToken;

  TrelloBloc({
    required this.getAllBoards,
    required this.getListsOnABoard,
    required this.getCardsOnAList,
    required this.verifyToken,
    required this.setToken,
  }) : super(TrelloLoadingState()) {
    on<FetchTrelloBoardEvent>(_fetchBoards);
    on<FetchTrelloListsEvent>(_fetchLists);
    on<FetchTrelloCardsEvent>(_fetchCards);
    on<TrelloVerifyEvent>(_verifyToken);
    on<TrelloSetEvent>(_setToken);
  }

  void _verifyToken(TrelloVerifyEvent event, Emitter<TrelloState> emit) async {
    emit(TrelloLoadingState());
    try {
      final verified = await verifyToken(event.token);
      if (verified) {
        emit(TrelloVerifiedState());
      } else {
        emit(TrelloInitState());
      }
    } catch (error) {
      emit(TrelloInitState());
    }
  }

  void _setToken(TrelloSetEvent event, Emitter<TrelloState> emit) async {
    emit(TrelloLoadingState());
    try {
      await setToken(event.token, event.trelloToken);
      emit(TrelloVerifiedState());
    } catch (error) {
      emit(TrelloErrorState(error: error.toString()));
    }
  }

  void _fetchBoards(
      FetchTrelloBoardEvent event, Emitter<TrelloState> emit) async {
    emit(TrelloLoadingState());
    try {
      final boards = await getAllBoards(event.token);
      emit(TrelloBoardsLoadedState(boards: boards));
    } catch (error) {
      emit(TrelloInitState());
    }
  }

  void _fetchLists(
      FetchTrelloListsEvent event, Emitter<TrelloState> emit) async {
    emit(TrelloLoadingState());
    try {
      final lists = await getListsOnABoard(event.token, event.boardId);
      emit(TrelloListsLoadedState(lists: lists));
    } catch (error) {
      emit(TrelloInitState());
    }
  }

  void _fetchCards(
      FetchTrelloCardsEvent event, Emitter<TrelloState> emit) async {
    emit(TrelloLoadingState());
    try {
      final cards =
          await getCardsOnAList(event.token, event.boardId, event.listId);
      emit(TrelloCardsLoadedState(cards: cards));
    } catch (error) {
      emit(TrelloInitState());
    }
  }
}
