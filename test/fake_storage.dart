import 'package:auth_implementation/LocalStorage/local_storage.dart';

class FakeLocalStorage implements LocalStorage {
  String? token;

  @override
  Future<void> saveToken(String token) async {
    this.token = token;
  }

  @override
  Future<String?> getToken() async {
    return token;
  }

  @override
  Future<void> clearAll() async {
    token = null;
  }
}
