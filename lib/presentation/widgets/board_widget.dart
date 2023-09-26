// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/bloc/trello/bloc.dart';
import 'package:trello_tasks_sync/domain/entities/board.dart';

class BoardWidget extends StatefulWidget {
  final String token;
  final Board board;

  const BoardWidget({required this.token, required this.board, super.key});

  @override
  _BoardWidget createState() => _BoardWidget();
}

class _BoardWidget extends State<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    final trelloBloc = BlocProvider.of<TrelloBloc>(context);
    Board board = widget.board;
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      return ListTile(
          title: Text(
            board.name,
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            onPressed: () {
              trelloBloc.add(FetchTrelloListsEvent(
                  token: widget.token, boardId: board.id));
            },
            child: const Text('Open Board'),
          ));
    });
  }
}
