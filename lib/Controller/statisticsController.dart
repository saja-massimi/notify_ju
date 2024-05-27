import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class statisticsController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final User? auth = FirebaseAuth.instance.currentUser!;

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




  Future<int> totalFeedbacks(String feedback) async {
    int totalFeedbacks = 0;
    try {
      QuerySnapshot snapshot = await _db
          .collection('users')
          .where('feedback', isEqualTo: feedback)
          .get();
      totalFeedbacks = snapshot.docs.length;
      return totalFeedbacks;
    } catch (e) {
    print('Error fetching feedbacks: $e');
      return 0;
    }
  
}


  Future<double?> allReportResponseTime(String subAdminEmail) async {

List<String> reportTypes = [];
      switch (subAdminEmail) {
      case 'ama0193677@ju.edu.jo':
      reportTypes=['Infrastructural Damage'];
      
        break;
      case 'hla0207934@ju.edu.jo':
      reportTypes=['Fire','Injury'];
        break;
      case 'gad0200681@ju.edu.jo':
      reportTypes=['Fight','Stray Animals','Car Accident'];
        break;
      default:
      break;
    }

    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      List<int> allResponseTimes = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot = await userDoc.reference
            .collection('reports')
            .where('report_type', whereIn:reportTypes )
            .get();

        for (var doc in reportsSnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;

          if (data['under_review_timestamp'] != null && data['report_date'] != null) {
            DateTime underReviewTimestamp =
                data['under_review_timestamp'].toDate();
            DateTime reportDate = data['report_date'].toDate();
            int responseTime =
                underReviewTimestamp.difference(reportDate).inMinutes;
            log('Calculated response time: $responseTime minutes'); 
            allResponseTimes.add(responseTime);
          }
        }
      }

      log('All response times: $allResponseTimes'); 

      if (allResponseTimes.isNotEmpty) {
        double averageResponseTime =
            allResponseTimes.reduce((a, b) => a + b) / allResponseTimes.length;
        log('Average response time: $averageResponseTime minutes'); // Add logging here
        return averageResponseTime;
      } else {
        return null;
      }
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }

  Future<Map<String, dynamic>> getFeedback(int index) async {
    String feedback = "";
    switch (index) {
      case 1:
        feedback = "Very Bad";
        break;
      case 2:
        feedback = "Bad";
        break;
      case 3:
        feedback = "Good";
        break;
      case 4:
        feedback = "Very Good";
        break;
      case 5:
        feedback = "Excellent";
        break;
      default:
        throw ArgumentError("Invalid feedback index");
    }

    final docID = await getDocumentIdByEmail(auth?.email ?? "");
    try {
      await _db.collection('users').doc(docID).update({'feedback': feedback});
      log('Field added to user $docID');
      return {
        'status': 'success',
        'message': 'Feedback updated successfully',
        'feedback': feedback
      };
    } catch (e) {
      log('Error updating user: $e');
      return {
        'status': 'error',
        'message': 'Error updating feedback',
        'error': e.toString()
      };
    }
  }


Future<int> getUserFeedback(String email) async {
  try {
    var querySnapshot = await _db.collection('users')
        .where('user_email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var feedbackData = querySnapshot.docs[0].data()['feedback'];
      int feedback = 5;
      switch (feedbackData) {
      case  "Very Bad":
        feedback =1;
        break;
      case "Bad":
        feedback = 2;
        break;
      case "Good":
        feedback = 3;
        break;
      case "Very Good":
        feedback = 4;
        break;
      case "Excellent":
        feedback = 5;
        break;
      default:
        throw ArgumentError("Invalid feedback index");
    }
      log(feedback.toString());
      return feedback;
    } else {
      return 5; 
    }
  } catch (e) {
    log('Error getting user feedback: $e');
    return 5; 
  }
}


}
