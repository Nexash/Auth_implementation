import 'package:auth_implementation/LocalStorage/local_storage.dart';
import 'package:auth_implementation/Service/auth_services.dart';

class AuthController {
  final AuthService _authService;
  final LocalStorage _localStorage;

  AuthController(this._authService, this._localStorage);
  Future<bool> login({required String email, required String password}) async {
    {
      //_authController ley login lai call garxa sabai kam hunxa AuthService vanney class ko
      final response = await _authService.login(email, password);
      if (response['tokens'] != null &&
          response['tokens']['access-token'] != null) {
        final accessToken = response['tokens']['access-token'];
        final refreshToken = response['tokens']['refresh-token'];

        print("Access Token: $accessToken");
        print("Refresh Token: $refreshToken");
        await _localStorage.saveToken(accessToken);

        return true;
      }
      throw Exception(response['message'] ?? 'Invalid credentials');
    }
  }
}
