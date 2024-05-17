import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/sharedPref.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/email_auth.dart';
import 'package:notify_ju/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  List<int> notif = [
    await SharedPrefController.getNotif('fire'),
    await SharedPrefController.getNotif('car'),
    await SharedPrefController.getNotif('injury'),
    await SharedPrefController.getNotif('fight'),
    await SharedPrefController.getNotif('infra'),
    await SharedPrefController.getNotif('animal'),
  ];

  switch (message.data['report_type']) {
    case 'Fire':
      await SharedPrefController.setNotif('fire', notif[0] + 1);
      break;
    case 'Car Accident':
      await SharedPrefController.setNotif('car', notif[1] + 1);
      break;
    case 'Injury':
      await SharedPrefController.setNotif('injury', notif[2] + 1);
      break;
    case 'Fight':
      await SharedPrefController.setNotif('fight', notif[3] + 1);
      break;
    case 'Infrastructural Damage':
      await SharedPrefController.setNotif('infra', notif[4] + 1);
      break;
    case 'Stray Animals':
      await SharedPrefController.setNotif('fight', notif[5] + 1);
      break;
    default:
      log('Unknown notification received');
  }

  log("A message is received in the background");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SharedPrefController.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8D7999)),
          useMaterial3: true,
        ),
        home: const email_auth());
  }
}
