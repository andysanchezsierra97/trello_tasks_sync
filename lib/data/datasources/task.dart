import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class TaskDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Task>> getAll(String token) async {
    try {
      final userId = await _getCurrentUser(token);
      if (userId == null) {
        throw 'Invalid token';
      }

      final tasksSnapshot = await firestore
          .collection('task')
          .where('userId', isEqualTo: userId)
          .get();

      final tasks = tasksSnapshot.docs.map((doc) {
        final data = doc.data();

        return Task(
            userId: userId,
            id: doc.id,
            title: data['title'],
            description: data['description'],
            createdAt: data['createdAt'].toDate(),
            updatedAt: data['updatedAt'].toDate(),
            isCompleted: data['isCompleted']);
      }).toList();
      tasks.sort((a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        } else {
          return a.createdAt.compareTo(b.createdAt);
        }
      });
      return tasks;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> create(String token, String title, String description) async {
    try {
      final userId = await _getCurrentUser(token);
      if (userId == null) {
        throw 'Invalid token';
      }

      await firestore.collection('task').add({
        'userId': userId,
        'title': title,
        'description': description,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'isCompleted': false
      });
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> update(String token, String id, String title, String description,
      bool isCompleted) async {
    try {
      final userId = await _getCurrentUser(token);
      if (userId == null) {
        throw 'Invalid token';
      }

      final taskSnapshot = await firestore
          .collection('task')
          .where(FieldPath.documentId, isEqualTo: id)
          .where('userId', isEqualTo: userId)
          .get();

      if (taskSnapshot.docs.isEmpty) {
        throw 'Invalid token';
      }

      await taskSnapshot.docs.first.reference.update({
        'title': title,
        'description': description,
        'updatedAt': DateTime.now(),
        'isCompleted': isCompleted
      });
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> delete(String token, String id) async {
    try {
      final userId = await _getCurrentUser(token);
      if (userId == null) {
        throw 'Invalid token';
      }
      final taskSnapshot = await firestore
          .collection('task')
          .where(FieldPath.documentId, isEqualTo: id)
          .where('userId', isEqualTo: userId)
          .get();

      if (taskSnapshot.docs.isEmpty) {
        throw 'Invalid token';
      }

      await taskSnapshot.docs.first.reference.delete();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String?> _getCurrentUser(String token) async {
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
      return userSnapshot.docs.first.id;
    } catch (e) {
      return null;
    }
  }
}
