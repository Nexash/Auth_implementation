import 'package:flutter/material.dart';

class ReusableButtomSheet extends StatefulWidget {
  final String title;
  final Widget child;
  final double initialSize;
  final double minSize;
  final double maxSize;
  const ReusableButtomSheet({
    super.key,
    required this.title,
    required this.child,
    this.initialSize = 0.5,
    this.minSize = 0.3,
    this.maxSize = 6,
  });

  @override
  State<ReusableButtomSheet> createState() => _ReusableButtomSheetState();
}

class _ReusableButtomSheetState extends State<ReusableButtomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 30, 29, 29),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(
                context,
              ).viewInsets.bottom, // avoids keyboard overlap
        ),
        child: IntrinsicHeight(
          child: Container(
            width: MediaQuery.of(context).size.width - 0.5,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 180, 178, 178),
                  ),
                ),
                SizedBox(height: 20),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
