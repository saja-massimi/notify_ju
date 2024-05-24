import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
// import 'package:notify_ju/Controller/ReportsController.dart';
// import 'package:notify_ju/Controller/WarningsController.dart';
// import 'package:notify_ju/Models/warningModel.dart';
// import 'package:random_string/random_string.dart';

class SubAdminsController extends GetxController {
  static SubAdminsController get instance => Get.find();

  Future<List<Map<String, dynamic>>?> viewAllReports(String reportType) async{
  
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

  Future<void> changeReportStatusSubAdmin(String type, String reportID, String email) async {
    
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


// Future<void> unchnagedStatus(reportId,subAdminEmail) async{


// final controller = Get.put(ReportsController());
// final warningController = Get.put(WarningsController());
// final rand = randomAlphaNumeric(20);

// controller.viewReport(reportId).then((value) {
//   if(value!=null){
//     if(value['report_status']=='Pending'){
//       DateTime reportTime = DateTime.parse(value['report_time']);
//       DateTime currentTime = DateTime.now();

//     log(value.toString());  



//       if(currentTime.difference(reportTime).inMinutes>5){
        
//       warningController.createWarning(WarningModel(
//         id: rand,
//         subAdminEmail: subAdminEmail,
//         message:  "You have not responded to the report for more than 5 hours", 
//         timestamp: DateTime.now()
//       ));
//       }
//     }
//   }
// });


// }




}