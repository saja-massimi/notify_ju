import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/reportNotification.dart';
import 'package:notify_ju/Screens/sign_in.dart';
import 'package:notify_ju/add_report.dart';
import 'package:notify_ju/categories.dart';
import 'package:notify_ju/firebase_options.dart';
import 'package:notify_ju/image_input.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home:Categories() ,
  
    );
    
  }
}



