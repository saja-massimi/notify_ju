import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SubAdminsController extends GetxController {
  static SubAdminsController get instance => Get.find();





  Future<List<Map<String, dynamic>>?> viewAllReportsReports(String reportType) async{
  
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> allReports = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot = await userDoc.reference
            .collection('reports')
            .where("report_type", isEqualTo: reportType)
            .get();

        allReports.addAll(reportsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
      }


      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }


}






}