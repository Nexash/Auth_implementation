// lib/core/storage/shared_prefs_storage.dart
import 'dart:convert';

import 'package:auth_implementation/Modal/Login/Response/login_response_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class SharedPrefsStorage implements LocalStorage {
  final SharedPreferences prefs;

  SharedPrefsStorage(this.prefs);

  // Save access token
  @override
  Future<void> saveToken(String token) async {
    await prefs.setString(StorageKeys.token, token);
  }

  // Get access token
  @override
  String? getToken() {
    return prefs.getString(StorageKeys.token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await prefs.setString(StorageKeys.refreshToken, refreshToken);
  }

  // Get refresh token
  @override
  Future<String?> getRefreshToken() async {
    return prefs.getString(StorageKeys.refreshToken);
  }

  // Save user info
  @override
  Future<void> saveUser(User user) async {
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(StorageKeys.user, userJson);
  }

  // Get user info
  @override
  User? getUser() {
    String? userJson = prefs.getString(StorageKeys.user);
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  // Set login status
  @override
  Future<void> setLoggedIn(bool isLoggedIn) async {
    await prefs.setBool(StorageKeys.isLoggedIn, isLoggedIn);
  }

  // Get login status
  @override
  bool isLoggedIn() {
    return prefs.getBool(StorageKeys.isLoggedIn) ?? false;
  }

  // Clear all data (logout)
  @override
  void clearAll() {
    prefs.clear();
  }
}
