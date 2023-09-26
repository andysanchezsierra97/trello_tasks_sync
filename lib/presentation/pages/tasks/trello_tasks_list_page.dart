// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/trello/bloc.dart';
import 'package:trello_tasks_sync/presentation/widgets/connect_form_widget.dart';
import 'package:trello_tasks_sync/presentation/widgets/list_boards_widget.dart';
import 'package:trello_tasks_sync/presentation/widgets/list_cards_widget.dart';
import 'package:trello_tasks_sync/presentation/widgets/list_lists_widget.dart';

class TrelloTaskListPage extends StatefulWidget {
  final String token;
  const TrelloTaskListPage({super.key, required this.token});

  @override
  _TrelloTaskListPageState createState() => _TrelloTaskListPageState();
}

class _TrelloTaskListPageState extends State<TrelloTaskListPage> {
  @override
  void initState() {
    super.initState();
    final taskBloc = BlocProvider.of<TrelloBloc>(context);
    taskBloc.add(TrelloVerifyEvent(token: widget.token));
  }

  final TextEditingController tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String error = "";
    return Scaffold(
      body: BlocConsumer<TrelloBloc, TrelloState>(
        listener: (context, state) {
          final trelloBloc = BlocProvider.of<TrelloBloc>(context);
          if (state is TrelloVerifiedState) {
            trelloBloc.add(FetchTrelloBoardEvent(token: widget.token));
          }
          if (state is TrelloErrorState) {
            error = state.error;
            trelloBloc.add(TrelloVerifyEvent(token: widget.token));
          }
        },
        builder: (context, state) {
          if (state is TrelloInitState) {
            return ConnectTrelloForm(token: widget.token, error: error);
          } else if (state is TrelloLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TrelloBoardsLoadedState) {
            final boards = state.boards;
            if (boards.isEmpty) {
              return const Center(child: Text("No boards to show"));
            } else {
              return ListBoardWidget(token: widget.token, boards: boards);
            }
          } else if (state is TrelloListsLoadedState) {
            final lists = state.lists;
            if (lists.isEmpty) {
              return const Center(child: Text("No lists to show"));
            } else {
              return ListListsWidget(token: widget.token, lists: lists);
            }
          } else if (state is TrelloCardsLoadedState) {
            final cards = state.cards;
            if (cards.isEmpty) {
              return const Center(child: Text("No cards to show"));
            } else {
              return ListCardsWidget(token: widget.token, cards: cards);
            }
          }
          return Container();
        },
      ),
      floatingActionButton: null,
    );
  }
}
