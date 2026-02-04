import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/Controller/password_controller.dart';
import 'package:auth_implementation/Network/dio_client.dart';
import 'package:auth_implementation/Service/auth_services.dart';
import 'package:auth_implementation/Service/password_service.dart';
import 'package:auth_implementation/UI/Login_Register/Register/register_screen.dart';
import 'package:auth_implementation/UI/Login_Register/login/login_screen.dart';
import 'package:auth_implementation/UI/home_screen.dart';
import 'package:auth_implementation/UI/landing_screen.dart';
import 'package:auth_implementation/Utils/LocalStorage/shared_pref_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  late final GoRouter _router;
  MyApp({super.key, required this.isLoggedIn}) {
    _router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/',
      redirect: (context, state) {
        final currentLocation = state.uri.toString();
        if (!isLoggedIn && currentLocation != '/') return '/';
        if (isLoggedIn && currentLocation == '/') return '/homeScreen';
        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => LandingScreen()),
        GoRoute(
          path: '/loginScreen',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/registerScreen',
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(path: '/homeScreen', builder: (context, state) => HomeScreen()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //.router added
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      routerConfig: _router,
      debugShowCheckedModeBanner: false,

      // home: isLoggedIn ? HomeScreen() : LandingScreen(),
    );
  }
}
