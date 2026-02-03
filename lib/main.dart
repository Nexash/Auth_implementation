import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/Controller/password_controller.dart';
import 'package:auth_implementation/Network/dio_client.dart';
import 'package:auth_implementation/Service/auth_services.dart';
import 'package:auth_implementation/Service/password_service.dart';
import 'package:auth_implementation/UI/home_screen.dart';
import 'package:auth_implementation/UI/landing_screen.dart';
import 'package:auth_implementation/Utils/LocalStorage/shared_pref_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final localStorage = SharedPrefsStorage(prefs);

  final dioClient = DioClient(localStorage);
  final authService = AuthService(dioClient.dio);
  final passwordService = PasswordService(dioClient.dio);

  final passwordController = PasswordController(passwordService, localStorage);

  final authController = AuthController(authService, localStorage);
  //  Inject AuthController into Dio interceptor after auth controller is made
  dioClient.setAuthController(authController);
  dioClient.setPasswordController(passwordController);

  // Check if user is logged in

  final bool isLoggedIn = localStorage.isLoggedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PasswordController>.value(
          value: passwordController,
        ),
        ChangeNotifierProvider<AuthController>.value(value: authController),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      navigatorKey: navigatorKey,
      home: isLoggedIn ? HomeScreen() : LandingScreen(),
    );
  }
}
