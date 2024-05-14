import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:notify_ju/Repository/authentication_repository.dart';

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)
    );

    return Scaffold(
      body: Center(
        child: Image.asset('images/amanzimgs/splash.gif'), 
      ),
    );
  }
}
