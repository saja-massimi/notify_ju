
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
  return snapshot.docs[0].data()["role"]=="admin";
  
}

return false;

}


Future<void> changeReportStatus(String type, String reportID, String email) async {
  QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('user_email', isEqualTo: email)
      .get();

  if (usersSnapshot.docs.isNotEmpty) {
    CollectionReference reportsCollection = usersSnapshot.docs.first.reference.collection('reports');

    QuerySnapshot reportSnapshot = await reportsCollection
        .where('report_id', isEqualTo: reportID)
        .where('user_email', isEqualTo: email)
        .get();

    if (reportSnapshot.docs.isNotEmpty) {
      DocumentSnapshot reportDoc = reportSnapshot.docs.first;
      Map<String, dynamic> dataToUpdate = {
        'report_status': type, 
      };

      await reportDoc.reference.update(dataToUpdate);
    } else {
      log('Report not found for the given ID and email.');
    }
  } else {
    log('User not found for the given email.');
  }
}




}