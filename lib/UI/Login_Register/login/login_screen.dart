import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/UI/Login_Register/Register/register_screen.dart';
import 'package:auth_implementation/UI/home_screen.dart';
import 'package:auth_implementation/Utils/GlobalAccess/show_loading_dialog.dart';
import 'package:auth_implementation/Utils/Helpers/login_register_nav_helper.dart';
import 'package:auth_implementation/Utils/Helpers/validator_helper.dart';
import 'package:auth_implementation/Utils/ReusableWidgets/text_field.dart';
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

  void loginchecker(BuildContext context) async {
    final authController = context.read<AuthController>();
    if (!_formKey.currentState!.validate()) return;
    showLoadingDialog(context);

    try {
      final success = await authController.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (success == true) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
          (route) => false,
        );
        emailController.clear();
        passwordController.clear();
      }
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
                        focusNode: emailFocus,
                        nextFocusNode: passwordFocus,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: 15),

                      CustomTextField(
                        controller: passwordController,
                        hint: "Password",
                        focusNode: passwordFocus,

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
                  onPressed: () => loginchecker(context),

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
