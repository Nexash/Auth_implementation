import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/UI/home_screen.dart';
import 'package:flutter/material.dart';

class LoginHandler {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final AuthController authController;

  LoginHandler({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.authController,
  });

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final bool success = await authController.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context);

      if (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      emailFocus.unfocus();
      passwordFocus.unfocus();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
