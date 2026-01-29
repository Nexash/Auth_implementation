import 'package:flutter/material.dart';

class PulseImageLoader extends StatefulWidget {
  const PulseImageLoader({super.key});

  @override
  State<PulseImageLoader> createState() => _PulseImageLoaderState();
}

class _PulseImageLoaderState extends State<PulseImageLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: Image.asset('assets/images/loading.gif', width: 150, height: 150),
    );
  }
}
