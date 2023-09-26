import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/trello/bloc.dart';
import 'package:trello_tasks_sync/domain/entities/card.dart';
import 'package:trello_tasks_sync/presentation/widgets/card_widget.dart';

class ListCardsWidget extends StatefulWidget {
  final String token;
  final List<TCard> cards;
  const ListCardsWidget({Key? key, required this.token, required this.cards})
      : super(key: key);

  @override
  State<ListCardsWidget> createState() => _ListCardsWidget();
}

class _ListCardsWidget extends State<ListCardsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cards'), centerTitle: true, actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final trelloBloc = BlocProvider.of<TrelloBloc>(context);
              trelloBloc.add(FetchTrelloListsEvent(
                  token: widget.token, boardId: widget.cards[0].boardId));
            },
          ),
        ]),
        body: Center(
            child: ListView.builder(
          itemCount: widget.cards.length,
          itemBuilder: (context, index) {
            final card = widget.cards[index];
            return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.teal.shade800),
                ),
                child: CardWidget(card: card, token: widget.token));
          },
        )));
  }
}
