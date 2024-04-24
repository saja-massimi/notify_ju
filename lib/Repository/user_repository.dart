import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Models/userModel.dart';

class UserRepository extends GetxController {


static UserRepository get instance => Get.find();

final _db = FirebaseFirestore.instance;


Future<UserModel> getUserDetails (String email) async{

final snapshot = await _db.collection("users").where("user_email", isEqualTo: email).get();
final userData = snapshot.docs.map((e) => UserModel.fromJSnapshot(e)).single;
return userData;



}
}