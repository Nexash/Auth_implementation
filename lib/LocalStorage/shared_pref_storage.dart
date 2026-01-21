// lib/core/storage/shared_prefs_storage.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class SharedPrefsStorage implements LocalStorage {
  final SharedPreferences prefs;

  SharedPrefsStorage(this.prefs);

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString(StorageKeys.token, token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(StorageKeys.token);
  }

  @override
  Future<void> clearAll() async {
    await prefs.clear();
  }
}
