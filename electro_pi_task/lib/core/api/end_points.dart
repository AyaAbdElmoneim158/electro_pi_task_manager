abstract class FirestorePath {
  static String usersPath(String uid) => '$usersCollection/$uid';

  static const String usersCollection = 'users';
  static const String todosCollection = 'todos';
  static const String projectsCollection = 'projects';
}

class FirestoreKeys {
  static const String id = 'id';
  static const String todos = 'todos';
 static const String completed =  'completed';
 

}

class StorageKeys {
  static const String tokenKey = 'jwt_token';
  static const String projectsKey = 'PROJECTS';
}
