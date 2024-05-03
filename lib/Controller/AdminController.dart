
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _authRepo = Get.put(AuthenticationRepository());

Future<bool> isAdmin() async{
  
final email = _authRepo.firebaseUser.value?.email;

if(email!=null){

  final snapshot = await _db.collection("users").where("user_email", isEqualTo: email).get();
  log(snapshot.docs[0].data()["role"]);
  return snapshot.docs[0].data()["role"]=="admin";
  
}

return false;

}



}