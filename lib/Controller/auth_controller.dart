import 'package:auth_implementation/Service/auth_services.dart';

class AuthController {
  final AuthService _authController = AuthService();
  Future<bool> login({required String email, required String password}) async {
    {
      //_authController ley login lai call garxa sabai kam hunxa AuthService vanney class ko
      final response = await _authController.login(email, password);
      if (response['tokens'] != null &&
          response['tokens']['access-token'] != null) {
        final accessToken = response['tokens']['access-token'];
        final refreshToken = response['tokens']['refresh-token'];

        print("Access Token: $accessToken");
        print("Refresh Token: $refreshToken");

        return true;
      }
      throw Exception(response['message'] ?? 'Invalid credentials');
    }
  }
}
