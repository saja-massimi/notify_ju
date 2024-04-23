import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/email_OTP.dart';
import 'package:notify_ju/Screens/email_auth.dart';

class AuthenticationRepository extends GetxController {


static AuthenticationRepository get instance => Get.find();

final _auth  = FirebaseAuth.instance;
late final Rx<User?> firebaseUser; 

@override
void onReady(){

firebaseUser = Rx<User?>(_auth.currentUser);
firebaseUser.bindStream(_auth.authStateChanges());
setInitialScreen(firebaseUser.value);

}

void  setInitialScreen(User? user){
  if(user == null){
    Get.offAll( ()=>const email_auth());
    
    }
  else if(user.emailVerified == true){
    Get.offAll(  ()=> Categories());
  }else
  {
    Get.offAll( ()=>const email_otp());
  
  }


}

Future<void> login(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
                                    

  } catch (e) {
    Get.snackbar('Error', e.toString());
  }

}

Future<void> logout()async{
  await _auth.signOut();
}


Future<void> sendVerfCode() async
{
  try{
    await _auth.currentUser?.sendEmailVerification();
Get.snackbar("Email", 'Verification link has been sent to your email address. Please verify your email address to continue.');
  }catch(e){
    Get.snackbar('Error', 'An error occured while sending the verification link');
  }


}


}







