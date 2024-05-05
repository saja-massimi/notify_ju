

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class ReportNotification extends  GetxController {

  static ReportNotification get instance => Get.find();


// getToken() async{
// String? mytoken = await FirebaseMessaging.instance.getToken();
// log(mytoken!);
// }

// @override
// void onInit(){
//   getToken();
// super.onInit();
// }


Future<List<Map<String, dynamic>>> getReports(String reportType) async {
  try {
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<Map<String, dynamic>> allReports = [];

    for (var userDoc in usersSnapshot.docs) {
      QuerySnapshot reportsSnapshot = await userDoc.reference
          .collection('reports')
          .where("report_type", isEqualTo: reportType)
          .get();

      allReports.addAll(reportsSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>));
    }

    print(allReports.toString()); 

    return allReports;
  } catch (e) {
    log("Error fetching reports: $e");
    throw e; 
  }
}
  
Future<List<Map<String, dynamic>>> getReportsDetails(String reportType) async {
  try {
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<Map<String, dynamic>> allReports = [];

    for (var userDoc in usersSnapshot.docs) {
      QuerySnapshot reportsSnapshot = await userDoc.reference
          .collection('reports')
          .where("report_type", isEqualTo: reportType)
          .get();

      allReports.addAll(reportsSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>));
    }

    print(allReports.toString()); 

    return allReports;
  } catch (e) {
    log("Error fetching reports: $e");
    throw e; 
  }
}


}


