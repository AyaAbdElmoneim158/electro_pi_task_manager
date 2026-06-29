abstract class Collection {
  static String usersPath(String uid) => '$usersCollection/$uid';
  
  static const String usersCollection = 'users';
}

class StorageKeys {
  static const String tokenKey = 'jwt_token';
}
