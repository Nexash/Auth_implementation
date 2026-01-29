import 'dart:developer';

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
  // String? _accessToken;
  // String? _refreshToken;
  bool imageLoaded = false;

  late AuthController authController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.getUserData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Assign the provider once
    if (!mounted) return;
    authController = Provider.of<AuthController>(context, listen: false);

    // // Load user data only once
    // if (_user == null) {
    //   _loadUserData();
    // }
  }

  // Future<void> _loadUserData() async {
  //   User? user = authController.localStorage.getUser();
  //   String? accessToken = authController.localStorage.getToken();
  //   String? refreshToken = await authController.localStorage.getRefreshToken();

  //   setState(() {
  //     _user = user;
  //     _accessToken = accessToken;
  //     _refreshToken = refreshToken;
  //   });
  // }

  void _logout() {
    authController.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (4 == null) {
    //   return Scaffold(

    //     appBar: AppBar(title: Text("Home")),
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 29, 29),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Welcome ",
            style: TextStyle(
              color: const Color.fromARGB(255, 212, 207, 207),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: const Color.fromARGB(255, 176, 173, 173),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<AuthController>(
                builder: (context, authController, child) {
                  if (authController.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (authController.userdata == null) {
                    log("--------user data is empty");
                    return Text("No data found");
                  }
                  if (authController.errorMessage != null) {
                    return Center(child: Text(authController.errorMessage!));
                  }

                  if (authController.userdata != null) {
                    final user = authController.userdata!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              height: 120,
                              width: 120,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                color: Colors.white,
                              ),

                              //Stack used to show the loader on top of the image while it’s loading
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/profile.jpg',
                                    fit: BoxFit.contain,
                                    frameBuilder: (context, child, frame, _) {
                                      if (frame != null && !imageLoaded) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                              if (mounted) {
                                                setState(
                                                  () => imageLoaded = true,
                                                );
                                              }
                                            });
                                      }
                                      return child; // ✅ ALWAYS return a widget
                                    },
                                  ),

                                  if (!imageLoaded)
                                    const CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Name: ${user.firstname} ${user.lastname}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 212, 207, 207),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "Username: ${user.username}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 176, 173, 173),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Email: ${user.email}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 176, 173, 173),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
