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
    try {
      final response = await _authService.login(email, password);

      final loginResponse = LoginResponseModal.fromJson(response);

      await _localStorage.saveToken(loginResponse.tokens.accessToken);
      await _localStorage.saveRefreshToken(loginResponse.tokens.refreshToken);

      await _localStorage.saveUser(loginResponse.user);

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
  void logout() {
    _localStorage.clearAll();
  }
}
