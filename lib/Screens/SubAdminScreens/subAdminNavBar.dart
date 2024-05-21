import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminMain.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNotifications.dart';

class subadminNavigationBarWidget extends StatefulWidget {
  const subadminNavigationBarWidget({super.key});

  @override
  State<subadminNavigationBarWidget> createState() =>
      _subadminNavigationBarWidgetState();
}

class _subadminNavigationBarWidgetState extends State<subadminNavigationBarWidget> {



 getCurrentUser(){
  final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is currently signed out!');
    } else if(user.email == 'ama0193677@ju.edu.jo') {
      return subAdminMain(reportTypes: const ['Infrastructural Damage'],adminName: 'Public Services');  
    }else if(user.email == 'hla0207934@ju.edu.jo'){
return subAdminMain(reportTypes: const ['Fire','Injury'],adminName: 'Emergency Services');
    }else if(user.email == 'gad0200681@ju.edu.jo'){
return subAdminMain(reportTypes: const ['Fight','Stray Animals','Car Accident'],adminName: 'Security Services');
    }

  }



  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: const Color(0xFF464A5E),
        shape: const CircularNotchedRectangle(),
        notchMargin: 50,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is currently signed out!');
    } else if(user.email == 'ama0193677@ju.edu.jo') {
      Get.to(subAdminNotifications( reportType:const ['Infrastructural Damage']));  
    }else if(user.email == 'hla0207934@ju.edu.jo'){
          Get.to(subAdminNotifications(reportType: const ['Fire','Injury']));
    }else if(user.email == 'gad0200681@ju.edu.jo'){
      Get.to(  subAdminNotifications(reportType: const ['Fight','Stray Animals','Car Accident']));
    
              } },
              icon: const Icon(Icons.notifications, color: Colors.white),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  getCurrentUser()));
                },
                icon: const Icon(Icons.home, color: Colors.white)),
          
          
          ],
        ));
  }
}
