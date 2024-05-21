// ignore_for_file: unused_field, non_constant_identifier_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';

class MailAuthenticationController extends GetxController {
  late Timer _timer;
   final auth_repo= Get.put(AuthenticationRepository()); 

  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }

  Future<void> sendVerificationEmail() async {
    await auth_repo.sendVerfCode();
  }

  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      FirebaseAuth.instance.currentUser?.reload();

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        auth_repo.setInitialScreen(null);
        timer.cancel();
      } else if (user.emailVerified) {
        timer.cancel();
        auth_repo.setInitialScreen(user);
      }
    });
  }
}
