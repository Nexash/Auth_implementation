import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/ReusableWidgets/text_field.dart';
import 'package:auth_implementation/UI/Login_Register/register_screen.dart';
import 'package:auth_implementation/UI/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.read<AuthController>();
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: FocusScope(
            autofocus: false,
            child: ListView(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15, // 30%
                ),
                Center(
                  child: Text(
                    "Aayulogic",
                    style: TextStyle(
                      fontFamily: 'EightOne',
                      color: Colors.white,
                      fontSize: 40,

                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    "RealHRSoft",
                    style: TextStyle(
                      fontFamily: 'EightOne',
                      color: Colors.white,
                      fontSize: 40,

                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05, // 30%
                ),
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      // fontFamily: 'EightOne',
                      color: Colors.white,
                      fontSize: 30,

                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(
                        controller: emailController,
                        focusNode: emailFocus,
                        hint: "Email",
                        icon: Icons.email,
                        autofocus: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email cannot be empty";
                          }

                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      buildTextField(
                        controller: passwordController,
                        hint: "Password",
                        focusNode: passwordFocus,
                        obscure: true,
                        icon: Icons.lock,
                        isVisible: isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                        onToggleVisibility: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        autofocus: false,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 199, 195, 195),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Validate form first
                    if (_formKey.currentState!.validate()) {
                      // Show a loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                      );
                      try {
                        final bool success = await authController.login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        Navigator.pop(context);
                        if (success == true) {
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
                        // close loader
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 199, 195, 195),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 199, 195, 195),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
