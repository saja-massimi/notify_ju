// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notify_ju/Models/reportModel.dart';
import 'package:notify_ju/Repository/user_repository.dart'; 

class SendNotification extends GetxController {


static SendNotification get instance => Get.find();

final con = Get.put(UserRepository());

  
Future<String> GetToken() async{

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_email', isEqualTo: 'sja0202385@ju.edu.jo')
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {  
return (querySnapshot.docs.first.data() as Map<String, dynamic>)['fcmtoken'] as String;
    } else {
      return 'null';
    }

}
Future<void> MyrequestPremission() async{

FirebaseMessaging messaging = FirebaseMessaging.instance;
NotificationSettings settings = await messaging.requestPermission(

  alert: true,
  badge: true,
  provisional: false,
  sound: true,
);
if(settings.authorizationStatus == AuthorizationStatus.authorized){
  log('User granted permission');
}else if(settings.authorizationStatus == AuthorizationStatus.provisional){
  log('User granted provisional permission');
}else{
  log('User declined or has not accepted permission');
}

}

Future<void> sendNotification(title,message,reportModel rep) async{
  var headersList = {
  'Accept': '*/*',
  'Content-Type': 'application/json',
  'Authorization': 'key=AAAAyvpO5hE:APA91bF3tr_j_O6tNjhVWzRUC63-z8IEH_WMvOSo0UNk2YaOJtbQamRxBi4l7YRdDHwkmpsZEFn_5D7Uzlu8E5qdYuRup25XLvuRCbfUwoxa5ojvXKt2u_e1_r0uJWvy7KsC37Fq_f-t' 
};
var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

var body = {
    "to": GetToken,
    "notification": {
      "title":title,
      "body": message,
      "mutable_content": true,
      "sound": "default",
      },

    "data": {
    "report_type": rep.report_type,
      }
};

var req = http.Request('POST', url);
req.headers.addAll(headersList);
req.body = json.encode(body);


var res = await req.send();
final resBody = await res.stream.bytesToString();

if (res.statusCode >= 200 && res.statusCode < 300) 
{
  log(rep.report_type);
  log(resBody);
}
else {
  log(res.reasonPhrase!);
}
}


@override
void onInit(){
MyrequestPremission();
super.onInit();
}



}
