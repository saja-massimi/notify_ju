import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)
        , () {

final c = Get.put(AuthenticationRepository());
c.setInitialScreen( c.firebaseUser.value);
    }
    
    );

    return Scaffold(
      body: Center(
        child: Image.asset('images/amanzimgs/splash.gif'),
      ),
    );
  }
}