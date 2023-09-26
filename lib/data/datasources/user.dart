import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> register(String username, String password) async {
    try {
      final documentSnapshot = await firestore
          .collection('user')
          .where('username', isEqualTo: username)
          .get();
      if (documentSnapshot.docs.isNotEmpty) {
        throw 'The username is already exist';
      }

      await firestore.collection('user').add({
        'username': username,
        'password': BCrypt.hashpw(password, BCrypt.gensalt()),
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'trelloToken': ''
      });

      return _generateJwt(username);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String> login(String username, String password) async {
    try {
      final userSnapshot = await firestore
          .collection('user')
          .where('username', isEqualTo: username)
          .get();
      if (userSnapshot.docs.isEmpty) {
        throw 'Invalid username';
      }
      final userData = userSnapshot.docs.first;
      final storedPassword = userData["password"];

      if (!BCrypt.checkpw(password, storedPassword)) {
        throw 'Invalid password.';
      }

      return _generateJwt(username);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String?> getCurrentUser(String token) async {
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

      return token;
    } catch (e) {
      return null;
    }
  }

  String _generateJwt(String username) {
    final jwt = JWT({
      'username': username,
    });

    return jwt.sign(SecretKey('trello_task_sync_jwt_secret'));
  }
}
