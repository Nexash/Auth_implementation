import 'package:auth_implementation/Controller/auth_controller.dart';

class LoginHandler {
  final AuthController authController;

  LoginHandler({required this.authController});

  Future<bool> login({required String email, required String password}) async {
    try {
      final bool success = await authController.login(
        email: email,
        password: password,
      );

      return success;
    } catch (e) {
      rethrow;
    }
  }
}
