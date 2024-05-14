import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:notify_ju/Screens/email_auth.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => email_auth());
    });

    return Scaffold(
      body: Center(
        child: Image.asset('images/amanzimgs/splash.gif'),
      ),
    );
  }
}
