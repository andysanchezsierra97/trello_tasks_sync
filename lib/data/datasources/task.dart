import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Task>> getAll() async {
    try {
      final querySnapshot = await firestore.collection('task').get();
      final tasks = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Task(
            id: doc.id, title: data['title'], description: data['description']);
      }).toList();
      return tasks;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<Task> getById(String id) async {
    try {
      final documentSnapshot = await firestore.collection('task').doc(id).get();
      final data = documentSnapshot.data() as Map<String, dynamic>;
      return Task(
          id: documentSnapshot.id,
          title: data['title'],
          description: data['description']);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> create(Task task) async {
    try {
      await firestore
          .collection('task')
          .add({'title': task.title, 'description': task.description});
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> update(Task task) async {
    try {
      await firestore
          .collection('task')
          .doc(task.id)
          .update({'title': task.title, 'description': task.description});
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection('task').doc(id).delete();
    } catch (error) {
      throw error.toString();
    }
  }
}
