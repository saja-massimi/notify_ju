
// ignore_for_file: await_only_futures

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/sharedPref.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminMain.dart';
import 'package:notify_ju/Screens/Home.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminMain.dart';
import 'package:notify_ju/Screens/email_OTP.dart';
import 'package:notify_ju/Screens/email_auth.dart';
import 'package:notify_ju/Screens/splashScreen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser = Rx<User?>(_auth.currentUser);

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  int s = await SharedPrefController.getNotif('notifs');
  await SharedPrefController.setNotif('notifs', s + 1);
  log("A message is received in the background");

if(message.data['type'] == 'Infrastructural Damage'|| message.data['type'] == 'Car Accident'){
  int publicUnitNotif = await SharedPrefController.getNotif('publicUnitNotif');
  await SharedPrefController.setNotif('publicUnitNotif', publicUnitNotif + 1);
  }
  else if(message.data['type'] == 'Fire' || message.data['type'] == 'Injury'){
  int emergencyUnitNotif = await SharedPrefController.getNotif('emergencyUnitNotif');
  await SharedPrefController.setNotif('emergencyUnitNotif', emergencyUnitNotif + 1);}
  else if(message.data['type'] == 'Fight' || message.data['type'] == 'Stray Animals' ){
  int securityUnitNotif = await SharedPrefController.getNotif('securityUnitNotif');
  await SharedPrefController.setNotif('securityUnitNotif', securityUnitNotif + 1);
}

}


  @override
  void onInit() {
    super.onInit();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      firebaseUser.bindStream(_auth.authStateChanges());
      ever<User?>(firebaseUser, (user) {
      setInitialScreen(user);
      
    });
  }
    
  Future<void> setInitialScreen(User? user) async{

  Get.to(() => const SplashScreen()); 
  await Future.delayed(const Duration(seconds: 3));

  if (user == null) {
    Get.offAll(() => const email_auth());
  } else if (user.emailVerified == true) {
    if(user.email == 'sja0202385@ju.edu.jo'){
      Get.offAll(() =>  const AdminMain()); 
      }
      else {
      switch (user.email) {
      case 'ama0193677@ju.edu.jo':
        Get.offAll(() =>  const subAdminMain(reportTypes: ['Infrastructural Damage'],adminName: 'Public Services')); 
        break;
      case 'hla0207934@ju.edu.jo':
        Get.offAll(() =>  const subAdminMain(reportTypes: ['Fire','Injury'],adminName: 'Emergency Services')); 
        break;
      case 'gad0200681@ju.edu.jo':
        Get.offAll(() =>  const subAdminMain(reportTypes: ['Fight','Stray Animals','Car Accident'], adminName: 'Security',)); 
        break;
      default:
      Get.offAll(() =>  HomePage()); break;
    }
    }
  } else {
    Get.offAll(() => const email_otp()); 
  }

}

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar('Error', "Username or password is incorrect");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.snackbar('Logout', 'You have been logged out');

  }

  Future<void> sendVerfCode() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      Get.snackbar("Email", 'Verification link has been sent to your email address. Please verify your email address to continue.');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while sending the verification link');
    }
  }
}
