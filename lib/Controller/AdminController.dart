// ignore_for_file: unused_local_variable, await_only_futures

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Controller/sharedPref.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';

class AdminController extends GetxController {
  AdminController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _authRepo = Get.put(AuthenticationRepository());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    updateFCMToken();
    receiveNotification();
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

  Future<void> updateFCMToken() async {
    String? fcmToken;
    try {
      fcmToken = await _firebaseMessaging.getToken();
      log('FCM Token: $fcmToken');
      final rep = Get.put(ReportsController());
      final documentId = await rep.getDocumentIdByEmail("sja0202385@ju.edu.jo");

      await _db.collection("users").doc(documentId).update({
        "fcmToken": fcmToken,
      });
    } catch (e) {
      log('Error retrieving FCM token: $e');
    }
  }

  Future<void> receiveNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('message received');

      if (await isAdmin()) {
        Get.snackbar(
          'New Report',
          'A new ${message.data["report_type"]} report has been submitted',
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      int notif = await SharedPrefController.getNotif('notifs');
      await SharedPrefController.setNotif('notifs', notif + 1);
      if (message.data['type'] == 'Infrastructural Damage' ||
          message.data['type'] == 'Car Accident') {
        int publicUnitNotif =
            await SharedPrefController.getNotif('publicUnitNotif');
        await SharedPrefController.setNotif(
            'publicUnitNotif', publicUnitNotif + 1);
      } else if (message.data['type'] == 'Fire' ||
          message.data['type'] == 'Injury') {
        int emergencyUnitNotif =
            await SharedPrefController.getNotif('emergencyUnitNotif');
        await SharedPrefController.setNotif(
            'emergencyUnitNotif', emergencyUnitNotif + 1);
      } else if (message.data['type'] == 'Fight' ||
          message.data['type'] == 'Stray Animals') {
        int securityUnitNotif =
            await SharedPrefController.getNotif('securityUnitNotif');
        await SharedPrefController.setNotif(
            'securityUnitNotif', securityUnitNotif + 1);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getPost() async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> allReports = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot postsSnapshot =
            await userDoc.reference.collection('post').get();

        for (var postDoc in postsSnapshot.docs) {
          Map<String, dynamic> postData =
              postDoc.data() as Map<String, dynamic>;
          if (postData.containsKey('likesCount') &&
              postData['likesCount'] is List) {
            List<dynamic> likesCountArray = postData['likesCount'];
            postData['totalLikes'] = likesCountArray.length;
          } else {
            postData['totalLikes'] = 0;
          }

          allReports.add(postData);
        }
      }

      allReports.sort((a, b) => b['totalLikes'].compareTo(a['totalLikes']));

      return allReports;
    } catch (e) {
      log("Error fetching posts: $e");
      throw e;
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      var postDoc = await _firestore
          .collectionGroup('post')
          .where('post_id', isEqualTo: postId)
          .where('email', isNotEqualTo: _authRepo.firebaseUser.value?.email)
          .get();
      for (var doc in postDoc.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error deleting post: $e');
      throw e;
    }
  }

  Future<void> deleteComment(String postId, String commentId) async {
    try {
      var commentDoc = await _firestore
          .collectionGroup('comments')
          .where('comment_id', isEqualTo: commentId)
          .where('post_id', isEqualTo: postId)
          .where('email', isNotEqualTo: _authRepo.firebaseUser.value?.email)
          .get();
      for (var doc in commentDoc.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error deleting comment: $e');
      throw e;
    }
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
        if (type == "Under Review") {
          dataToUpdate['under_review_timestamp'] = FieldValue.serverTimestamp();
        }

        await reportDoc.reference.update(dataToUpdate);
      } else {
        log('Report not found for the given ID and email.');
      }
    } else {
      log('User not found for the given email.');
    }
  }

  Future<List<Map<String, dynamic>>> getReportStatus(
      String status, List<String> reportType) async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> allReports = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot = await userDoc.reference
            .collection('reports')
            .where("report_status", isEqualTo: status)
            .where("report_type", whereIn: reportType)
            .orderBy("report_date", descending: true)
            .get();

        allReports.addAll(reportsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
      }

      allReports.sort((a, b) => (b['report_date'] as Timestamp)
          .compareTo(a['report_date'] as Timestamp));

      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
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

        reportsSnapshot.docs.forEach((doc) {
          var data = doc.data() as Map<String, dynamic>;
          if (data['report_status'] == 'Under Review') {
            allReports.add(data);
          }
        });
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

        allReports.addAll(reportsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
      }
      log(allReports.toString());

      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getHistoryReports() async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> allReports = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot = await userDoc.reference
            .collection('reports')
            .where("report_status", whereIn: ["Resolved", "Rejected"]).get();

        reportsSnapshot.docs.forEach((doc) {
          var data = doc.data() as Map<String, dynamic>;
          allReports.add(data);
        });
      }

      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getReportsHistorySub(
      List<String> reportType) async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> allReports = [];

      for (var userDoc in usersSnapshot.docs) {
        deletePost(String postId) {}
        QuerySnapshot reportsSnapshot = await userDoc.reference
            .collection('reports')
            .where("report_type", isEqualTo: reportType)
            .where('report_status', whereIn: ['Resolved', 'Rejected']).get();

        allReports.addAll(reportsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
      }
      log(allReports.toString());

      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getAllAdmins() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('users')
          .where('role', isEqualTo: 'admin')
          .where('user_email', isNotEqualTo: 'sja0202385@ju.edu.jo')
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching admins: $e');
      return [];
    }
  }
}
