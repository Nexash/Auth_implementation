import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/Modal/Login/Response/login_response_modal.dart';
import 'package:auth_implementation/UI/Login_Register/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  String? _accessToken;
  String? _refreshToken;

  late AuthController authController;

  @override
  void initState() {
    super.initState();
    // Fetch provider after first frame
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Assign the provider once
    if (!mounted) return;
    authController = Provider.of<AuthController>(context, listen: false);

    // Load user data only once
    if (_user == null) {
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    User? user = await authController.localStorage.getUser();
    String? accessToken = await authController.localStorage.getToken();
    String? refreshToken = await authController.localStorage.getRefreshToken();

    setState(() {
      _user = user;
      _accessToken = accessToken;
      _refreshToken = refreshToken;
    });
  }

  Future<void> _logout() async {
    await authController.localStorage.clearAll();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${_user!.firstName}"),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _logout)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name: ${_user!.firstName} ${_user!.lastName}"),
            SizedBox(height: 10),
            Text("Email: ${_user!.email}"),
            SizedBox(height: 10),
            Text("Username: ${_user!.username}"),
            SizedBox(height: 20),
            Text("Access Token: $_accessToken"),
            SizedBox(height: 10),
            Text("Refresh Token: $_refreshToken"),
          ],
        ),
      ),
    );
  }
}
