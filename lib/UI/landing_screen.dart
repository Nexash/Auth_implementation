import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/UI/Login_Register/login_screen.dart';
import 'package:auth_implementation/UI/Login_Register/register_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final AuthController authController;
  const LandingScreen({super.key, required this.authController});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "This is the Landing Page",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Select Sign up button if you already have an account and if not select register button",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 165, 163, 163),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          LoginScreen(authController: widget.authController),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("Sign Up", style: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("Register", style: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}
