import 'package:flutter/material.dart';
import 'package:trello_tasks_sync/domain/entities/board.dart';
import 'package:trello_tasks_sync/presentation/widgets/board_widget.dart';

class ListBoardWidget extends StatefulWidget {
  final String token;
  final List<Board> boards;
  const ListBoardWidget({Key? key, required this.token, required this.boards})
      : super(key: key);

  @override
  State<ListBoardWidget> createState() => _ListBoardWidget();
}

class _ListBoardWidget extends State<ListBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Boards'),
          centerTitle: true,
        ),
        body: Center(
            child: ListView.builder(
          itemCount: widget.boards.length,
          itemBuilder: (context, index) {
            final board = widget.boards[index];
            return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.teal.shade800),
                ),
                child: BoardWidget(board: board, token: widget.token));
          },
        )));
  }
}
