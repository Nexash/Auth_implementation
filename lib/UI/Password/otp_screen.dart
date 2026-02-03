import 'package:auth_implementation/Controller/password_controller.dart';
import 'package:auth_implementation/UI/Login_Register/login/login_screen.dart';
import 'package:auth_implementation/Utils/GlobalAccess/show_loading_dialog.dart';
import 'package:auth_implementation/Utils/Helpers/validator_helper.dart';
import 'package:auth_implementation/Utils/ReusableWidgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode otpFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  void otpResetPassword(BuildContext context) async {
    final passwordController = context.read<PasswordController>();
    if (!_formKey.currentState!.validate()) return;
    showLoadingDialog(context);

    try {
      final success = await passwordController.otpResetPassword(
        email: widget.email,
        otp: otpcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
        confirm_password: confirmPasswordController.text.trim(),
      );
      if (success) {
        otpcontroller.clear();
        passwordcontroller.clear();
        confirmPasswordController.clear();
        FocusManager.instance.primaryFocus?.unfocus();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password Reset Succesfull.")),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        });
      }
    } catch (e) {
      FocusManager.instance.primaryFocus?.unfocus();
      final navigator = Navigator.of(context, rootNavigator: true);
      navigator.pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception:', ''))),
      );
      otpcontroller.clear();
      passwordcontroller.clear();
      confirmPasswordController.clear();
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 29, 29),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 212, 207, 207),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 25),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hint: "OTP",
                      icon: Icons.key,
                      validator: Validators.otp,
                      controller: otpcontroller,
                      focusNode: otpFocus,
                      keyboardType: TextInputType.number,
                      nextFocusNode: passwordFocus,
                    ),
                    SizedBox(height: 15),
                    CustomTextField(
                      hint: "New Password",
                      icon: Icons.password,
                      controller: passwordcontroller,
                      focusNode: passwordFocus,
                      validator: Validators.validatePassword,
                      nextFocusNode: confirmPasswordFocus,
                    ),
                    SizedBox(height: 15),
                    CustomTextField(
                      hint: "Confirm New Password",
                      icon: Icons.password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != passwordcontroller.text) {
                          return "Password do not Match";
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocus,
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(170, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          otpResetPassword(context);
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
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
