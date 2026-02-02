import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/Utils/ReusableWidgets/text_field.dart';
import 'package:auth_implementation/UI/Login_Register/login/login_screen.dart';
import 'package:auth_implementation/Utils/GlobalAccess/show_loading_dialog.dart';
import 'package:auth_implementation/Utils/Helpers/validator_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode usernameFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();

  void registerchecker(BuildContext context) async {
    final authController = context.read<AuthController>();
    if (!_formKey.currentState!.validate()) return;
    showLoadingDialog(context);
    await Future.delayed(Duration(milliseconds: 100));

    try {
      final success = await authController.register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        username: usernameController.text.trim(),
        firstname: firstNameController.text.trim(),
        lastname: lastNameController.text.trim(),
      );

      if (success == true) {
        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Register Successful.")));
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
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    usernameFocus.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 29, 29),
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08, // 30%
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

              SizedBox(height: 50),
              Center(
                child: Text(
                  "Register",
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
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: firstNameController,
                            hint: "First Name",
                            icon: Icons.person,
                            validator: Validators.firstName,
                            focusNode: firstNameFocus,
                            nextFocusNode: lastNameFocus,
                          ),
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: CustomTextField(
                            controller: lastNameController,
                            hint: "Last Name",
                            icon: Icons.person_outline,
                            validator: Validators.lastName,
                            focusNode: lastNameFocus,
                            nextFocusNode: usernameFocus,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomTextField(
                      controller: usernameController,
                      hint: "Username",
                      icon: Icons.account_circle,
                      validator: Validators.validateUsername,
                      focusNode: usernameFocus,
                      nextFocusNode: emailFocus,
                    ),

                    SizedBox(height: 15),

                    CustomTextField(
                      controller: emailController,
                      hint: "Email",
                      icon: Icons.email,
                      validator: Validators.validateEmail,
                      focusNode: emailFocus,
                      nextFocusNode: passwordFocus,
                    ),

                    SizedBox(height: 15),

                    CustomTextField(
                      controller: passwordController,
                      hint: "Password",
                      obscure: true,
                      icon: Icons.lock,
                      validator: Validators.validatePassword,
                      focusNode: passwordFocus,
                      nextFocusNode: confirmPasswordFocus,
                    ),

                    SizedBox(height: 15),

                    CustomTextField(
                      controller: confirmPasswordController,
                      hint: "Confirm Password",
                      obscure: true,
                      icon: Icons.lock,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != passwordController.text) {
                          return "Password do not Match";
                        }
                        return null;
                      },
                      focusNode: confirmPasswordFocus,
                    ),

                    SizedBox(height: 15),

                    Align(
                      alignment: Alignment.center,
                      child: IntrinsicWidth(
                        child: ElevatedButton(
                          onPressed: () => registerchecker(context),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(200, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text("Sign Up"),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 246, 245, 245),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
