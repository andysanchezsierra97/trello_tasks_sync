import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:trello_tasks_sync/domain/entities/list.dart';
import 'package:trello_tasks_sync/domain/entities/user.dart';
import 'package:trello_tasks_sync/domain/entities/board.dart';
import 'package:trello_tasks_sync/domain/entities/card.dart';

class TrelloDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final apiKey = "002902dcd1855305f84972de3779369f";
  final secret =
      "e7cc6154825c0d6214ec2a3c09a5233736aa3b7400bd9422e3ce66b1320a2aa5";

  Future<bool> verifyToken(String token) async {
    try {
      final user = await _getCurrentUser(token);
      if (user == null || user.trelloToken == "") {
        return false;
      }

      final trelloToken = user.trelloToken;
      final url =
          "https://api.trello.com/1/members/me/?key=$apiKey&token=$trelloToken";
      final res = await http.get(Uri.parse(url));

      if (res.statusCode != 200) {
        await firestore.collection('user').doc(user.id).update({
          'trelloToken': "",
          'updatedAt': DateTime.now(),
        });

        return false;
      }

      return true;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> setToken(String token, String trelloToken) async {
    try {
      final user = await _getCurrentUser(token);

      if (user == null) {
        throw 'Invalid token';
      }

      final url =
          "https://api.trello.com/1/members/me/?key=$apiKey&token=$trelloToken";
      final res = await http.get(Uri.parse(url));

      if (res.statusCode != 200) {
        throw 'Invalid token';
      }

      await firestore.collection('user').doc(user.id).update({
        'trelloToken': trelloToken,
        'updatedAt': DateTime.now(),
      });
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<Board>> getAllBoards(String token) async {
    try {
      final user = await _getCurrentUser(token);
      if (user == null) {
        throw 'Invalid token';
      }

      final trelloToken = user.trelloToken;
      var memberRes = await http.get(Uri.parse(
          "https://api.trello.com/1/members/me/?key=$apiKey&token=$trelloToken"));

      if (memberRes.statusCode != 200) {
        throw 'Invalid token';
      }

      var memberJson =
          convert.jsonDecode(memberRes.body) as Map<String, dynamic>;

      List<Board> boards = [];
      List<dynamic> boardsIds = memberJson['idBoards'];

      for (String id in boardsIds) {
        var boardRes = await http.get(Uri.parse(
            "https://api.trello.com/1/boards/$id?key=$apiKey&token=$trelloToken"));

        var boardJson =
            convert.jsonDecode(boardRes.body) as Map<String, dynamic>;

        boards.add(Board(id: boardJson['id'], name: boardJson['name']));
      }

      return boards;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<TList>> getListsOnABoard(String token, String boardId) async {
    try {
      final user = await _getCurrentUser(token);
      if (user == null) {
        throw 'Invalid token';
      }

      final trelloToken = user.trelloToken;
      var listsRes = await http.get(Uri.parse(
          "https://api.trello.com/1/boards/$boardId/lists/?key=$apiKey&token=$trelloToken"));

      var listsJson = convert.jsonDecode(listsRes.body) as List<dynamic>;

      List<TList> lists = [];

      for (var list in listsJson) {
        lists.add(TList(boardId: boardId, id: list['id'], name: list['name']));
      }

      return lists;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<TCard>> getCardsOnAList(
      String token, String boardId, String listId) async {
    try {
      final user = await _getCurrentUser(token);
      if (user == null) {
        throw 'Invalid token';
      }

      final trelloToken = user.trelloToken;
      var cardsRes = await http.get(Uri.parse(
          "https://api.trello.com/1/lists/$listId/cards/?key=$apiKey&token=$trelloToken"));

      var cardsJson = convert.jsonDecode(cardsRes.body) as List<dynamic>;

      List<TCard> cards = [];

      for (var card in cardsJson) {
        cards.add(TCard(
            boardId: boardId,
            listId: listId,
            id: card['id'],
            name: card['name']));
      }

      return cards;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<User?> _getCurrentUser(String token) async {
    try {
      final jwt = JWT.verify(token, SecretKey('trello_task_sync_jwt_secret'));
      final username = jwt.payload['username'];
      final userSnapshot = await firestore
          .collection('user')
          .where('username', isEqualTo: username)
          .get();

      if (userSnapshot.docs.isEmpty) {
        return null;
      }

      final userData = userSnapshot.docs.first;

      final user = User(
        id: userData.id,
        username: userData['username'],
        password: "",
        createdAt: userData['createdAt'].toDate(),
        updatedAt: userData['updatedAt'].toDate(),
        trelloToken: userData['trelloToken'],
      );

      return user;
    } catch (e) {
      return null;
    }
  }
}
