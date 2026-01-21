class StorageKeys {
  static const String token = 'token';
  static const String userId = 'user_id';
  static const String isLoggedIn = 'is_logged_in';
}

abstract class LocalStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearAll();
}
