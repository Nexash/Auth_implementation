import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/ReusableWidgets/text_field.dart';
import 'package:auth_implementation/UI/Login_Register/register_screen.dart';
import 'package:auth_implementation/Utils/Helpers/login_button.helper.dart';
import 'package:auth_implementation/Utils/Helpers/login_register_nav_helper.dart';
import 'package:auth_implementation/Utils/Helpers/validator_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late LoginHandler loginHandler;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  // late LoginHandler loginHandler;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    emailController
        .dispose(); //holds data waiting for user to come back to page if users clicks back
    passwordController
        .dispose(); // instantly clears the field even if user navigates to another page
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authController = context.read<AuthController>();
    loginHandler = LoginHandler(
      formKey: _formKey,
      emailController: emailController,
      passwordController: passwordController,
      emailFocus: emailFocus,
      passwordFocus: passwordFocus,
      authController: authController,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      CustomTextField(
                        controller: emailController,
                        // focusNode: emailFocus,
                        hint: "Email",
                        icon: Icons.email,
                        autofocus: false,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: 15),

                      CustomTextField(
                        controller: passwordController,
                        hint: "Password",
                        // focusNode: passwordFocus,
                        obscure: true,
                        icon: Icons.lock,
                        // isVisible: isPasswordVisible,
                        validator: Validators.validatePassword,
                        // onToggleVisibility: () {
                        //   setState(() {
                        //     isPasswordVisible = !isPasswordVisible;
                        //   });
                        // },
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
                  onPressed: () => loginHandler.login(context),
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
