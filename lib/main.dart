import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/email_auth.dart';
import 'package:notify_ju/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
SharedPreferences prefs = await SharedPreferences.getInstance();



  List<int> notif=[0,0,0,0,0,0];
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
log(' message sent');

switch (message.data['report_type']) {
    case 'Fire':
      prefs.setInt('fire', notif[0]++);
      break;
    case 'Car Accident':
      prefs.setInt('car', notif[1]++);      
      break;
      case 'Injury':
      prefs.setInt('injury', notif[2]++);
      break;
      case 'Fight':
      prefs.setInt('fight', notif[3]++);
      break;
      case 'Infrastructural Damage':
      prefs.setInt('infra', notif[4]++);
      break;
      case 'Stray Animals':
      prefs.setInt('animal', notif[5]++);
      break;
    default:
      log('Unknown notification received');
      
      }
  
});

  
  log("A message is recieved in the background");
  log("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF464A5E)),
          useMaterial3: true,
        ),
        home:  const email_auth());
  }
}
