import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electro_pi_task/core/api/end_points.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/data/source/todos_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodosFirebaseDataSource implements TodosDataSource {
  TodosFirebaseDataSource(this._auth, this._firestore);
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User is not logged in.');
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _projects => _firestore.collection(FirestorePath.usersCollection).doc(_uid).collection(FirestorePath.projectsCollection);

  @override
  Future<List<TodoModel>> getTodos(String projectId) async {
    final snapshot = await _projects.doc(projectId).collection(FirestorePath.todosCollection).get();
    return snapshot.docs.map((e) => TodoModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> addTodo({required String projectId, required TodoModel todo}) async {
    await _projects.doc(projectId).collection(FirestorePath.todosCollection).doc(todo.id as String?).set(todo.toJson());
  }

  @override
  Future<void> updateTodo({required String projectId, required TodoModel todo}) async {
    await _projects.doc(projectId).collection(FirestorePath.todosCollection).doc(todo.id as String?).update(todo.toJson());
  }

  @override
  Future<void> deleteTodo({required String projectId, required String todoId}) async {
    await _projects.doc(projectId).collection(FirestorePath.todosCollection).doc(todoId).delete();
  }

  @override
  Future<void> toggleTodoStatus({required String projectId, required String todoId, required bool completed}) async {
    await _projects.doc(projectId).collection(FirestorePath.todosCollection).doc(todoId).update({
      FirestoreKeys.completed: completed,
    });
  }
}
