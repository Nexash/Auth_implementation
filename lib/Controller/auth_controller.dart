import 'package:auth_implementation/Utils/LocalStorage/local_storage.dart';
import 'package:auth_implementation/Modal/Login/Response/login_response_modal.dart';
import 'package:auth_implementation/Service/auth_services.dart';
import 'package:auth_implementation/Utils/api_exception.dart';

class AuthController {
  final AuthService _authService;
  final LocalStorage _localStorage;
  LocalStorage get localStorage => _localStorage;

  AuthController(this._authService, this._localStorage);

  Future<bool> login({required String email, required String password}) async {
    // 1️⃣ Call API

    try {
      final response = await _authService.login(email, password);
      // 2️⃣ Convert response to model
      final loginResponse = LoginResponseModal.fromJson(response);

      // 3️⃣ Save tokens
      await _localStorage.saveToken(loginResponse.tokens.accessToken);
      await _localStorage.saveRefreshToken(loginResponse.tokens.refreshToken);

      // 4️⃣ Save user info
      await _localStorage.saveUser(loginResponse.user);

      // 5️⃣ Mark user as logged in
      await _localStorage.setLoggedIn(true);

      // Debug prints
      print("Access Token: ${loginResponse.tokens.accessToken}");
      print("Refresh Token: ${loginResponse.tokens.refreshToken}");
      print("User Info: ${loginResponse.user.toJson()}");

      return true;
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      } else {
        throw 'Something went wrong';
      }
    }
  }

  // Optional: Auto-login check
  Future<bool> checkLogin() async {
    return await _localStorage.isLoggedIn();
  }

  // Optional: Logout
  Future<void> logout() async {
    await _localStorage.clearAll();
  }
}
