
// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Models/reportModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:crypto/crypto.dart';

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
    }
  return null;
  
}

Future viewCurrentReports() async{
    final documentId = await getDocumentIdByEmail(auth?.email ?? "");
    log (documentId.toString());
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

Future<String> downloadAndHashImage(String imageUrl) async {
  final ref = FirebaseStorage.instance.refFromURL(imageUrl);
  final data = await ref.getData();
  if (data == null) {
    throw Exception('Failed to download image');
  }

  final digest = sha256.convert(data);

  return digest.toString();
}

Future<bool> areImagesSame(String url1) async {
  try {
    final hash1 = await downloadAndHashImage(url1);
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (var userDoc in usersSnapshot.docs) {
      QuerySnapshot reportsSnapshot =
          await userDoc.reference.collection('reports').get();

      for (var reportDoc in reportsSnapshot.docs) {
        var data = reportDoc.data() as Map<String, dynamic>;
        final hash2 = await downloadAndHashImage(data['image_url']);

        if (hash1 == hash2) {
          return true; 
        }
      }
    }

    return false; 
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> areDescriptionsSame(String desc) async {
  try {
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (var userDoc in usersSnapshot.docs) {
      QuerySnapshot reportsSnapshot =
          await userDoc.reference.collection('reports').get();

      for (var reportDoc in reportsSnapshot.docs) {
        var data = reportDoc.data() as Map<String, dynamic>;
        if (desc == data['report_description']) {
          return true; 
        }
      }
    }

    return false; 
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> canSubmitReport() async {

      final documentId = await getDocumentIdByEmail(auth?.email ?? "");

  final oneWeekAgo = Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 7)));

  QuerySnapshot reportsSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(documentId)
      .collection('reports')
      .where('report_date', isGreaterThan: oneWeekAgo)
      .get();

  return reportsSnapshot.docs.length < 5;
}

Future<bool> canSubmitSpam() async {
  
      final documentId = await getDocumentIdByEmail(auth?.email ?? "");
log(documentId.toString());
   QuerySnapshot reportsSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(documentId)
      .collection('reports')
      .orderBy('report_date', descending: true)
      .limit(1)
      .get();

  if (reportsSnapshot.docs.isEmpty) {
    return true;
  }

  var lastReportTimestamp = reportsSnapshot.docs.first['report_date'] as Timestamp;
  log(lastReportTimestamp.toString());
  var now = Timestamp.now();
  var difference = now.seconds - lastReportTimestamp.seconds;

  return difference >= 30; 
}

}