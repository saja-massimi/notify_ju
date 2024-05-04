
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class ReportNotification extends  GetxController {

  static ReportNotification get instance => Get.find();


getToken() async{
String? mytoken = await FirebaseMessaging.instance.getToken();
log(mytoken!);
}

@override
void onInit(){
  getToken();
super.onInit();
}

getReports(String reportType)async{
CollectionReference reports = FirebaseFirestore.instance.collection('Reports');
QuerySnapshot querySnapshot = await reports.where('type', isEqualTo: reportType).get();

return querySnapshot.docs;
}

// getFireReports(){


// }

// getCarAccidentReports(){

// }

// getStrayAnimalReports(){

// }

// getInjuryReports(){

// }

// getInfrastructureDamage(){

// }

}