import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electro_pi_task/core/error/server_exceptions.dart';
import 'package:flutter/foundation.dart';

abstract class FirestoreServices {
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  });
  Future<void> deleteData({required String path});
  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  });
  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  });

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  });
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  });
}

class FirestoreServicesImpl implements FirestoreServices {
  final FirebaseFirestore _fireStore;
  FirestoreServicesImpl({FirebaseFirestore? fireStore}) : _fireStore = fireStore ?? FirebaseFirestore.instance;

  @override
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    try {
      final reference = _fireStore.doc(path);
      debugPrint('✍️ Firestore Set: $path');
      await reference.set(data, SetOptions(merge: merge));
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    }
  }

  @override
  Future<void> deleteData({required String path}) async {
    try {
      final reference = _fireStore.doc(path);
      debugPrint('🗑️ Firestore Delete: $path');
      await reference.delete();
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    }
  }

  @override
  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    return _fireStore.doc(path).snapshots().map((snapshot) {
      return builder(snapshot.data(), snapshot.id);
    }).handleError((error) {
      if (error is FirebaseException) handleFirebaseException(error);
    });
  }

  @override
  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) query = queryBuilder(query);

    return query.snapshots().map((snapshot) {
      final result = snapshot.docs.map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id)).toList();
      if (sort != null) result.sort(sort);
      return result;
    }).handleError((error) {
      if (error is FirebaseException) handleFirebaseException(error);
    });
  }

  @override
  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) async {
    try {
      final reference = _fireStore.doc(path);
      final snapshot = await reference.get();
      if (!snapshot.exists) {
        throw FirebaseException(plugin: 'firestore', code: 'not-found');
      }
      return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
      rethrow;
    }
  }

  @override
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    try {
      Query query = _fireStore.collection(path);
      if (queryBuilder != null) query = queryBuilder(query);

      final snapshots = await query.get();
      final result = snapshots.docs.map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id)).toList();

      if (sort != null) result.sort(sort);
      return result;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
      return []; // Return empty list as fallback
    }
  }
}
