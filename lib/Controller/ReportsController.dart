
// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Models/reportModel.dart';

class ReportsController extends GetxController{
static ReportsController get instance => Get.find();
final _db = FirebaseFirestore.instance;
final User? auth = FirebaseAuth.instance.currentUser!;
final documentReference = FirebaseFirestore.instance.collection('users').doc();





Future<String?> getDocumentIdByEmail(String email) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return null;
    }
  } catch (error) {
    log('Error getting document ID by email: $error');
    return null;
  }
}




Future<void> createReport(reportModel report) async {
  try {
    final documentId = await getDocumentIdByEmail(auth?.email ?? "");
    if (documentId != null) {
      await _db
          .collection('users')
          .doc(documentId)
          .collection('reports')
          .doc(report.report_id)
          .set(report.toJson());
          
      Get.snackbar("Success", "Report sent successfully");
    } else {
      Get.snackbar("Error", "User not found");
    }
  } catch (error) {
    Get.snackbar("Error", 'Failed to create report: $error');
  }
}

Future<void> deleteReport (String reportId)async{
  
      final documentId = await getDocumentIdByEmail(auth?.email ?? "");


await _db.collection('/users/$documentId/reports').doc(reportId)
.delete()
.then((value) =>   
Get.snackbar("Success", "Report Deleted Succesfully")).
catchError((error) =>
Get.snackbar("Error", "Report Deletion Failed: $error")
);
}

Future<void> updateReport(String reportId, reportModel report) async{

    final documentId = await getDocumentIdByEmail(auth?.email ?? "");

await _db.collection('users/$documentId/reports').doc(reportId)
.update(report.toJson())
.then((value) =>Get.snackbar("Success", "Report Updated Succesfully")).
catchError((error) =>Get.snackbar("Error", "Report Update Failed: $error")
);
}

Future<Map<String, dynamic>?> viewReport(String reportId) async{
    final documentId = await getDocumentIdByEmail(auth?.email ?? "");

  try {
      final snapshot = await _db.collection('/users/$documentId/reports')
      .where("report_id", isEqualTo: reportId)
      .get();

      return snapshot.docs.map((doc) => doc.data()).single;
    } catch (e) {
      log("Error fetching reports: $e");
      return null;
    }
    
}

Future<List<Map<String, dynamic>>?> viewAllHistoryReports() async{
    final documentId = await getDocumentIdByEmail(auth?.email ?? "");

  try {
      final snapshot = await _db.collection('/users/$documentId/reports')
      .where("report_status", whereIn: ["Resolved", "Rejected"])
      .get();

      return snapshot.docs.map((doc) => doc.data()).toList();

  
    } catch (e) {
      
      log("Error fetching reports: $e");
      return null;
    }
  
}

Future viewCurrentReports() async{
    final documentId = await getDocumentIdByEmail(auth?.email ?? "");

  try {
    final snapshot = await _db.collection('/users/$documentId/reports')
      .where("report_status", isNotEqualTo: ["Resolved", "Rejected"])
      .get();

      return snapshot.docs.map((doc) => doc.data()).toList();

    } catch (e) {
      log("Error fetching reports: $e");
      return [];
    }


}

Future<int> viewAllHistoryReportsCount() async {
      final documentId = await getDocumentIdByEmail(auth?.email ?? "");

  try {
    final snapshot = await _db
        .collection('/users/$documentId/reports')
        .where("report_status",  whereIn: ["Resolved", "Rejected"])
        .get();
    return snapshot.size;
  } catch (e) {
    log("Error fetching reports: $e");
    return 0;
  }
}

Future<int> viewCurrentReportsCount() async {
      final documentId = await getDocumentIdByEmail(auth?.email ?? "");

  try {
    final snapshot = await _db
        .collection('/users/$documentId/reports')
        .where("report_status", isNotEqualTo: ["Resolved", "Rejected"])
        .get();
    return snapshot.size;
  } catch (e) {
    log("Error fetching reports: $e");
    return 0;
  }
}





}