import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';

class AdminController extends GetxController {
  AdminController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _authRepo = Get.put(AuthenticationRepository());


@override
void onInit(){
  updateFCMToken();
super.onInit();
}

  Future<bool> isAdmin() async {
    final email = _authRepo.firebaseUser.value?.email;

    if (email != null) {
      final snapshot = await _db
          .collection("users")
          .where("user_email", isEqualTo: email)
          .get();
      return snapshot.docs[0].data()["role"] == "admin";
    }

    return false;
  }

 final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

 Future<void>updateFCMToken() async {
    String? fcmToken;
    try {
      fcmToken = await _firebaseMessaging.getToken();
      log('FCM Token: $fcmToken');
      final rep = Get.put(ReportsController());
          final documentId = await rep.getDocumentIdByEmail("sja0202385@ju.edu.jo");

      await _db.collection("users").doc(documentId).update({
        "fcm_token": fcmToken,
      });


    } catch (e) {
      print('Error retrieving FCM token: $e');
    }
  }

  int receveNotification(String reportType) {
  int notif=0;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
log(' messagesent');
switch (reportType) {
    case 'Fire':
      notif++;
      break;
    case 'Car Accident':
      notif++;
      break;
      case 'Injury':
      notif++;
      break;
      case 'Fight':
      notif++;
      break;
      case 'Infrastructural Damage':
      notif++;
      break;
      case 'Stray Animals':
      notif++;
      break;
    default:
      log('Unknown notification received');
      
      }
  

});


      return notif;

  }

  Future<void> changeReportStatus(


      String type, String reportID, String email) async {
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_email', isEqualTo: email)
        .get();

    if (usersSnapshot.docs.isNotEmpty) {
      CollectionReference reportsCollection =
          usersSnapshot.docs.first.reference.collection('reports');

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

        allReports.addAll(reportsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
      }


      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getReportsDetails(
      String reportType) async {
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
      log(allReports.toString());

      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }



}