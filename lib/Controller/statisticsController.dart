
import 'dart:developer';

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

  Future<void> getFeedback(int index)async {
  String feedback="";
switch(index){
  case 1: feedback="Very Bad"; break;
  case 2: feedback="Bad"; break;
  case 3: feedback="Good"; break;
  case 4: feedback="Very Good"; break;
  case 5: feedback="Excellent"; break;
}

  
final docID = await getDocumentIdByEmail(auth?.email ?? "");
    try {
      
      await _db.collection('users').doc(docID).update({'feedback': feedback});
      log('Field added to user $docID');
    } catch (e) {
      log('Error updating user: $e');
    }
}

int totalFeedbacks(String feedback){
  int totalFeedbacks=0;
  try {
    QuerySnapshot snapshot =  _db.collection('users').where('feedback', isEqualTo: feedback).get() as QuerySnapshot<Object?>;
    totalFeedbacks=snapshot.docs.length;
    log( 'jioji $totalFeedbacks.toString()');
    return totalFeedbacks;
  } catch (e) {
    print('Error fetching admins: $e');
    return 0;
  }
}



}
