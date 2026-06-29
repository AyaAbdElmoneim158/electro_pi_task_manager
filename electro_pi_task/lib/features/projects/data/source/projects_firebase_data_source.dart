import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electro_pi_task/core/api/end_points.dart';
import 'package:electro_pi_task/features/projects/data/models/project_model.dart';
import 'package:electro_pi_task/features/projects/data/models/todo_model.dart';
import 'package:electro_pi_task/features/projects/data/source/projects_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectsFirebaseDataSource implements ProjectsDataSource {
  ProjectsFirebaseDataSource(this._auth, this._firestore);
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User is not logged in.');
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _projects => _firestore.collection(FirestorePath.usersCollection).doc(_uid).collection(FirestorePath.projectsCollection);

  @override
  Future<List<ProjectModel>> getProjects() async {
    final snapshot = await _projects.get();
    final List<ProjectModel> projects = [];

    for (final doc in snapshot.docs) {
      final todosSnapshot = await doc.reference.collection(FirestorePath.todosCollection).get();
      final todos = todosSnapshot.docs.map((e) => TodoModel.fromJson(e.data())).toList();
      projects.add(
        ProjectModel.fromJson({
          ...doc.data(),
          FirestoreKeys.id: doc.id,
          FirestoreKeys.todos: todos.map((e) => e.toJson()).toList(),
        }),
      );
    }

    return projects;
  }

  @override
  Future<ProjectModel> getProjectById(String projectId) async {
    final doc = await _projects.doc(projectId).get();
    if (!doc.exists) throw Exception('Project not found.');

    final todosSnapshot = await doc.reference.collection(FirestorePath.todosCollection).get();
    final todos = todosSnapshot.docs.map((e) => TodoModel.fromJson(e.data())).toList();
    return ProjectModel.fromJson({
      ...doc.data()!,
      FirestoreKeys.id: doc.id,
      FirestoreKeys.todos: todos.map((e) => e.toJson()).toList(),
    });
  }

  @override
  Future<void> addProject(ProjectModel project) async {
    final data = project.toJson()..remove(FirestorePath.todosCollection);
    await _projects.doc(project.id as String?).set(data);
    for (final todo in project.todos) {
      await _projects.doc(project.id as String?)
      .collection(FirestorePath.todosCollection)
      .doc(todo.id as String?).set(todo.toJson());
    }
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    final data = project.toJson()..remove(FirestorePath.todosCollection);
    await _projects.doc(project.id as String?).update(data);
  }

  @override
  Future<void> deleteProject(String projectId) async {
    final todos = await _projects.doc(projectId).collection(FirestorePath.todosCollection).get();
    for (final doc in todos.docs) {
      await doc.reference.delete();
    }
    await _projects.doc(projectId).delete();
  }
}
