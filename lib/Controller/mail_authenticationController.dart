import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';

class MailAuthenticationController extends GetxController {

// ignore: unused_field
late Timer _timer;

@override
void onInit() {
  super.onInit();
  sendVerficationEmail();
  setTimerForAutoRedirect();
  }

Future<void> sendVerficationEmail() async{
  
await AuthenticationRepository.instance.sendVerfCode();
}

void setTimerForAutoRedirect(){

_timer = Timer.periodic(const Duration(seconds: 5), (timer) {
  FirebaseAuth.instance.currentUser?.reload();

  final user = FirebaseAuth.instance.currentUser;
  if(user == null){
    return;
  }else
  if(user.emailVerified ){
    timer.cancel();
    AuthenticationRepository.instance.setInitialScreen(user);
  
  }
});

}






}