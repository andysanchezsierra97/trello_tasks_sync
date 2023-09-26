import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/trello/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectTrelloForm extends StatefulWidget {
  final String token;
  final String error;
  const ConnectTrelloForm({Key? key, required this.token, required this.error})
      : super(key: key);

  @override
  State<ConnectTrelloForm> createState() => _ConnectTrelloForm();
}

class _ConnectTrelloForm extends State<ConnectTrelloForm> {
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
        "https://trello.com/1/authorize?expiration=1day&name=MyPersonalToken&scope=read&response_type=token&key=002902dcd1855305f84972de3779369f");
    if (!await launchUrl(url)) {
      throw Exception('Failed to obtain token, please try again');
    }
  }

  final TextEditingController tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final trelloBloc = BlocProvider.of<TrelloBloc>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Center(
        child: SizedBox(
      height: height * 0.50,
      width: width * 0.75,
      child: Form(
        child: Column(
          children: <Widget>[
            const Text("Tap the next button to get your trello token"),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 20,
                ),
              ),
              onPressed: _launchUrl,
              child: const Text('Get Token'),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: tokenController,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintText: 'Token',
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.error,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 20,
                ),
              ),
              onPressed: () {
                final trelloToken = tokenController.text;

                if (trelloToken.isNotEmpty) {
                  tokenController.text = '';
                  trelloBloc.add(TrelloSetEvent(
                      token: widget.token, trelloToken: trelloToken));
                }
              },
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    ));
  }
}
