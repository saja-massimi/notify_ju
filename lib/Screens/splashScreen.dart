import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 3)
  
    // );

    return Scaffold(
      body: Center(
        child: Image.asset('images/amanzimgs/splash.gif'),
      ),
    );
  }
}