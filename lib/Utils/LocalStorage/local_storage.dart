import 'package:auth_implementation/Modal/Login/Response/login_response_modal.dart';

class StorageKeys {
  static const String token = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String user = 'user';
  static const String isLoggedIn = 'is_logged_in';
}

abstract class LocalStorage {
  // Access Token
  Future<void> saveToken(String token);
  String? getToken();

  // Refresh Token
  Future<void> saveRefreshToken(String token);
  String? getRefreshToken();

  // User Info
  Future<void> saveUser(User user);
  User? getUser();

  // Login Status
  Future<void> setLoggedIn(bool isLoggedIn);
  bool isLoggedIn();

  // Clear all stored data
  void clearAll();
}
