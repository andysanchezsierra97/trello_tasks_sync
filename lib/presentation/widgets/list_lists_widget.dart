import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/trello/bloc.dart';
import 'package:trello_tasks_sync/domain/entities/list.dart';
import 'package:trello_tasks_sync/presentation/widgets/list_widget.dart';

class ListListsWidget extends StatefulWidget {
  final String token;
  final List<TList> lists;
  const ListListsWidget({Key? key, required this.token, required this.lists})
      : super(key: key);

  @override
  State<ListListsWidget> createState() => _ListListsWidget();
}

class _ListListsWidget extends State<ListListsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lists'), centerTitle: true, actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final trelloBloc = BlocProvider.of<TrelloBloc>(context);
              trelloBloc.add(FetchTrelloBoardEvent(token: widget.token));
            },
          ),
        ]),
        body: Center(
            child: ListView.builder(
          itemCount: widget.lists.length,
          itemBuilder: (context, index) {
            final list = widget.lists[index];
            return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.teal.shade800),
                ),
                child: ListWidget(list: list, token: widget.token));
          },
        )));
  }
}
