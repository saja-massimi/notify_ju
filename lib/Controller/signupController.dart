import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';

class SignupController extends GetxController {

static SignupController get instance => Get.find();

final email = TextEditingController();  
final password = TextEditingController();

void loginUser (String email,String password)
{
  

  final auth = AuthenticationRepository.instance;
  auth.login(email.trim().toLowerCase(), password.trim());

  auth.setInitialScreen(auth.firebaseUser.value);

}

void logout() async{
  final auth = AuthenticationRepository.instance;
  auth.logout();






  
}

  }