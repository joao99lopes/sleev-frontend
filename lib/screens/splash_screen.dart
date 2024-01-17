import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double imageSize = 200.0; // Initial size of the image

  @override
  void initState() {
    super.initState();

    // Simulate a delay of 2 seconds
    Timer(const Duration(seconds: 3), () {
      // After the delay, navigate to the desired screen
      Navigator.pushReplacementNamed(context, '/home');
    });

    // Increase the image size gradually over 3 seconds
    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      if (imageSize < 400.0) {
        setState(() {
          imageSize *= 1.1;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 3), // Duration for image size animation
          width: imageSize,
          height: imageSize,
          child: Image.asset('assets/images/pikachu.jpg'),
        ),
      ),
    );
  }
}
