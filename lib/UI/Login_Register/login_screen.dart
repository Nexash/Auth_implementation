import 'dart:developer';

import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/ReusableWidgets/text_field.dart';
import 'package:auth_implementation/UI/Login_Register/register_screen.dart';
import 'package:auth_implementation/UI/home_screen.dart';
import 'package:auth_implementation/Utils/Helpers/login_button.helper.dart';
import 'package:auth_implementation/Utils/Helpers/login_register_nav_helper.dart';
import 'package:auth_implementation/Utils/Helpers/validator_helper.dart';
import 'package:auth_implementation/Utils/loading_helper.dart';
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
  bool _isHandlerReady = false;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  late LoginHandler loginHandler;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = context.read<AuthController>();
      loginHandler = LoginHandler(authController: authController);
      FocusScope.of(context).unfocus();
      setState(() {
        _isHandlerReady = true; // now button can be tapped safely
      });
    });
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 29, 29),

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
                      CustomTextField(
                        controller: emailController,

                        hint: "Email",
                        icon: Icons.email,
                        autofocus: false,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: 15),

                      CustomTextField(
                        controller: passwordController,
                        hint: "Password",

                        obscure: true,
                        icon: Icons.lock,

                        validator: Validators.validatePassword,

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
                  onPressed:
                      _isHandlerReady
                          ? () async {
                            if (!_formKey.currentState!.validate()) return;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder:
                                  (_) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Center(child: PulseImageLoader()),
                                    ),
                                  ),
                            );
                            await Future.delayed(Duration(seconds: 3));
                            try {
                              final success = await loginHandler.login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                              if (success && context.mounted) {
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                  (route) => false,
                                );
                                emailController.clear();
                                passwordController.clear();
                              }
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                              log(e.toString());
                              Navigator.pop(context);
                            }
                          }
                          : null,
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
                      onTap: () => NavigationHelper.goToRegister(context),

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
