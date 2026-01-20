import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent automatic pop
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        // Show confirmation dialog

        if (!didPop) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("Exit App"),
                  content: const Text("Do you want to close the app?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                        SystemNavigator.pop();
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [Text("Welcome", style: TextStyle(color: Colors.white))],
          ),
        ),
      ),
    );
  }
}
