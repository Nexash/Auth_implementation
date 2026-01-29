import 'package:auth_implementation/ReusableWidgets/text_field.dart';
import 'package:auth_implementation/UI/Login_Register/login_screen.dart';
import 'package:auth_implementation/Utils/Helpers/validator_helper.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 29, 29),
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
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
                          ),
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: CustomTextField(
                            controller: lastNameController,
                            hint: "Last Name",
                            icon: Icons.person_outline,
                            validator: Validators.lastName,
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
                    ),

                    SizedBox(height: 15),

                    CustomTextField(
                      controller: emailController,
                      hint: "Email",
                      icon: Icons.email,
                      validator: Validators.validateEmail,
                    ),

                    SizedBox(height: 15),

                    CustomTextField(
                      controller: passwordController,
                      hint: "Password",
                      obscure: true,
                      icon: Icons.lock,
                      // isVisible: isPasswordVisible,
                      // onToggleVisibility: () {
                      //   setState(() {
                      //     isPasswordVisible = !isPasswordVisible;
                      //   });
                      // },
                      validator: Validators.validatePassword,

                      //  if (value == null || value.isEmpty) {
                      //   return "Password cannot be empty";
                      // }
                      // if (value.length < 6) {
                      //   return "Password must be at least 6 characters";
                      // }
                      // // Optional: enforce at least 1 number and 1 special character
                      // final passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[!@#\$&*~]).{6,}$');
                      // if (!passwordRegex.hasMatch(value)) {
                      //   return "Password must contain a number and a special character";
                      // }
                      // return null;
                    ),

                    SizedBox(height: 15),

                    CustomTextField(
                      controller: confirmPasswordController,
                      hint: "Confirm Password",
                      obscure: true,
                      icon: Icons.lock,
                      // isVisible: isConfirmPasswordVisible,
                      // onToggleVisibility: () {
                      //   setState(() {
                      //     isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      //   });
                      // },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15),

                    Align(
                      alignment: Alignment.center,
                      child: IntrinsicWidth(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // All fields are valid
                            }
                          },
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
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
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
