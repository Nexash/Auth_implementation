import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/LocalStorage/shared_pref_storage.dart';
import 'package:auth_implementation/Network/dio_client.dart';
import 'package:auth_implementation/Service/auth_services.dart';
import 'package:auth_implementation/UI/home_screen.dart';
import 'package:auth_implementation/UI/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final localStorage = SharedPrefsStorage(prefs);

  final dioClient = DioClient(localStorage);
  final authService = AuthService(dioClient.dio);

  //Think of it like ordering food:
  // MyApp is a customer.
  // AuthController is a waiter.
  // AuthService is the chef.
  // DioClient is the kitchen staff fetching ingredients.
  // LocalStorage is the pantry.

  // thats why my app is taking authcontroller only
  final authController = AuthController(authService, localStorage);

  // Check if user is logged in

  final bool isLoggedIn = await localStorage.isLoggedIn();
  runApp(
    MultiProvider(
      providers: [Provider<AuthController>.value(value: authController)],
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
      home: isLoggedIn ? HomeScreen() : LandingScreen(),
    );
  }
}
