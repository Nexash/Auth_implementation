import 'package:auth_implementation/UI/Login_Register/login_screen.dart';
import 'package:auth_implementation/UI/Login_Register/register_screen.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  static void goToLogin(BuildContext context) {
    bool exists = false;
    Navigator.popUntil(context, (route) {
      if (route.settings.name == 'LoginScreen') exists = true;
      return true;
    });
    exists
        ? Navigator.pop(context)
        : Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
            settings: RouteSettings(name: 'LoginScreen'),
          ),
        );
  }

  static void goToRegister(BuildContext context) {
    bool exists = false;
    Navigator.popUntil(context, (route) {
      if (route.settings.name == 'RegisterScreen') exists = true;
      return true;
    });
    exists
        ? Navigator.pop(context)
        : Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RegisterScreen(),
            settings: RouteSettings(name: 'RegisterScreen'),
          ),
        );
  }
}
