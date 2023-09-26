// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/bloc/trello/bloc.dart';
import 'package:trello_tasks_sync/domain/entities/list.dart';

class ListWidget extends StatefulWidget {
  final String token;
  final TList list;

  const ListWidget({required this.token, required this.list, super.key});

  @override
  _ListWidget createState() => _ListWidget();
}

class _ListWidget extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    final trelloBloc = BlocProvider.of<TrelloBloc>(context);
    TList list = widget.list;
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      return ListTile(
          title: Text(
            list.name,
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            onPressed: () {
              trelloBloc.add(FetchTrelloCardsEvent(
                  token: widget.token, boardId: list.boardId, listId: list.id));
            },
            child: const Text('Open Card'),
          ));
    });
  }
}
