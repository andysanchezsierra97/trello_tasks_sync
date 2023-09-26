// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/domain/entities/card.dart';

class CardWidget extends StatefulWidget {
  final String token;
  final TCard card;

  const CardWidget({required this.token, required this.card, super.key});

  @override
  _CardWidget createState() => _CardWidget();
}

class _CardWidget extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    TCard card = widget.card;
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      return ListTile(
        title: Text(
          card.name,
        ),
      );
    });
  }
}
