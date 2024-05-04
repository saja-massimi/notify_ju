import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminMain.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/email_OTP.dart';
import 'package:notify_ju/Screens/email_auth.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser = Rx<User?>(_auth.currentUser);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever<User?>(firebaseUser, (user) {
      setInitialScreen(user);
    });
  }

  Future<void> setInitialScreen(User? user) async{

    final adminData = Get.put(AdminController());
  final isAdmin = await adminData.isAdmin();

  if (user == null) {
    Get.to(() => const email_auth());
  } else if (user.emailVerified == true) {
    if(isAdmin){
      Get.to(() =>const AdminMain());
    } else {
      Get.to(() => Categories());
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
