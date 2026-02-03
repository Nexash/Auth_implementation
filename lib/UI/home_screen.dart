import 'dart:developer';

import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/Controller/password_controller.dart';
import 'package:auth_implementation/UI/Login_Register/login/login_screen.dart';
import 'package:auth_implementation/UI/Password/otp_screen.dart';
import 'package:auth_implementation/Utils/GlobalAccess/show_loading_dialog.dart';
import 'package:auth_implementation/Utils/Helpers/validator_helper.dart';
import 'package:auth_implementation/Utils/ReusableWidgets/buttom_sheet.dart';
import 'package:auth_implementation/Utils/ReusableWidgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _mailformKey = GlobalKey<FormState>();

  FocusNode oldPasswordFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode confirmNewPasswordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  bool imageLoaded = false;

  late AuthController authController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.getUserData();
    });
  }

  void changePassword(BuildContext context) async {
    final passwordController = context.read<PasswordController>();
    if (!_formKey.currentState!.validate()) return;
    final parentContext = context;
    showLoadingDialog(parentContext);

    try {
      final success = await passwordController.changePassword(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmNewPassword: confirmNewPasswordController.text.trim(),
      );

      if (success == true) {
        //keyboard unfocus
        FocusManager.instance.primaryFocus?.unfocus();
        final navigator = Navigator.of(parentContext, rootNavigator: true);

        navigator.pop(); // close loading

        ScaffoldMessenger.of(parentContext).showSnackBar(
          SnackBar(content: Text("Password successfully changed.")),
        );
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmNewPasswordController.clear();
      }
    } catch (e) {
      FocusManager.instance.primaryFocus?.unfocus();
      final navigator = Navigator.of(parentContext, rootNavigator: true);
      navigator.pop(); // close loading

      ScaffoldMessenger.of(parentContext).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception:', ''))),
      );
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmNewPasswordController.clear();
    } finally {
      Navigator.of(parentContext, rootNavigator: true).pop();
    }
  }

  void resetPassword(BuildContext context) async {
    final passwordController = context.read<PasswordController>();
    if (!_mailformKey.currentState!.validate()) return;
    final parentContext = context;
    showLoadingDialog(parentContext);

    showLoadingDialog(context); // show loader

    try {
      final success = await passwordController.resetPassword(
        email: emailController.text.trim(),
      );

      if (!context.mounted) return;

      Navigator.of(context, rootNavigator: true).pop();

      if (success) {
        emailController.clear();
        FocusManager.instance.primaryFocus?.unfocus();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("OTP sent to email.")));
          final String email = emailController.text.trim();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => OTPScreen(email: email)),
          );
        });
      }
    } catch (e) {
      FocusManager.instance.primaryFocus?.unfocus();
      final navigator = Navigator.of(parentContext, rootNavigator: true);
      navigator.pop();
      navigator.pop();

      ScaffoldMessenger.of(parentContext).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception:', ''))),
      );
      emailController.clear();
    } finally {
      Navigator.of(parentContext, rootNavigator: true).pop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Assign the provider once
    if (!mounted) return;
    authController = Provider.of<AuthController>(context, listen: false);
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    newPasswordFocus.dispose();
    confirmNewPasswordFocus.dispose();
    oldPasswordFocus.dispose();
    super.dispose();
  }

  void logout() {
    authController.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: logout,
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
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(170, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    30,
                                    29,
                                    29,
                                  ),
                                  enableDrag: false,
                                  builder: (context) {
                                    return ReusableButtomSheet(
                                      title: "Change Password",
                                      initialSize: 0.4,
                                      minSize: 0.3,
                                      maxSize: 0.5,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            CustomTextField(
                                              validator:
                                                  Validators.validatePassword,
                                              hint: "Old Password",
                                              icon: Icons.password,
                                              controller: oldPasswordController,
                                              focusNode: oldPasswordFocus,
                                              nextFocusNode: newPasswordFocus,
                                            ),
                                            SizedBox(height: 15),
                                            CustomTextField(
                                              validator:
                                                  Validators.validatePassword,
                                              hint: "New Password",
                                              icon: Icons.password,
                                              controller: newPasswordController,
                                              focusNode: newPasswordFocus,
                                              nextFocusNode:
                                                  confirmNewPasswordFocus,
                                            ),
                                            SizedBox(height: 15),
                                            CustomTextField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please confirm your password";
                                                }
                                                if (value !=
                                                    newPasswordController
                                                        .text) {
                                                  return "Password do not Match";
                                                }
                                                return null;
                                              },
                                              hint: "Confirm New Password",
                                              icon: Icons.password,
                                              controller:
                                                  confirmNewPasswordController,
                                              focusNode:
                                                  confirmNewPasswordFocus,
                                            ),
                                            SizedBox(height: 15),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    changePassword(context);
                                                  },
                                                  child: Text("Confirm"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Change Password",
                                style: TextStyle(),
                              ),
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(170, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    30,
                                    29,
                                    29,
                                  ),
                                  enableDrag: false,
                                  builder: (context) {
                                    return ReusableButtomSheet(
                                      title: "Reset Password",
                                      initialSize: 0.4,
                                      minSize: 0.3,
                                      maxSize: 0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Enter your mail to reset password",
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                212,
                                                207,
                                                207,
                                              ),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Form(
                                            key: _mailformKey,
                                            child: CustomTextField(
                                              validator:
                                                  Validators.validateEmail,
                                              hint: "Email",
                                              icon: Icons.mail,
                                              controller: emailController,
                                              focusNode: emailFocus,
                                            ),
                                          ),
                                          SizedBox(height: 10),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  resetPassword(context);
                                                },
                                                child: Text("Confirm"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text("Reset Password", style: TextStyle()),
                            ),
                          ],
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
