import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class statisticsController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final User? auth = FirebaseAuth.instance.currentUser!;

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

  Future<Map<String, dynamic>> ReportData() async {
    int allReports = 0;
    int underviewReports = 0;
    int pendingReports = 0;
    int onHoldReports = 0;
    int rejectedReports = 0;
    int resolvedReports = 0;

    try {
      final reportsSnapshot = await _db.collectionGroup('reports').get();
      for (var report in reportsSnapshot.docs) {
        allReports++;
        switch (report['report_status']) {
          case 'Under Review':
            underviewReports++;
            break;
          case 'Pending':
            pendingReports++;
            break;
          case 'On Hold':
            onHoldReports++;
            break;
          case 'Rejected':
            rejectedReports++;
            break;
          case 'Resolved':
            resolvedReports++;
            break;
          default:
            break;
        }
      }
    } catch (e) {
      print('Error fetching report data: $e');
    }

    return {
      'allReports': allReports,
      'underviewReports': underviewReports,
      'pendingReports': pendingReports,
      'onHoldReports': onHoldReports,
      'rejectedReports': rejectedReports,
      'resolvedReports': resolvedReports,
    };
  }

  Future<List<Map<String, dynamic>>?> getAllWarnings(
      String subAdminEmail) async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'admin')
          .get();

      List<Map<String, dynamic>> allWarnings = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot = await userDoc.reference
            .collection('warnings')
            .where('subAdminEmail', isEqualTo: subAdminEmail)
            .get();

        for (var doc in reportsSnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          allWarnings.add(data);
        }
      }
      log(allWarnings.toString());
      return allWarnings;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }

  Future<List<int>?> AllReportResponceTime(String subAdminEmail) async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'admin')
          .get();

      List<int> allReports = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot = await userDoc.reference
            .collection('reports')
            .where('subAdminEmail', isEqualTo: subAdminEmail)
            .get();

        for (var doc in reportsSnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          if (data['under_review_timestamp'] != null) {
            var responseTime = data['under_review_timestamp']
                .toDate()
                .difference(data['report_date'].toDate())
                .inMinutes;
            allReports.add(responseTime);
          }
        }
      }
      log(allReports.toString());
      return allReports;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }
}
