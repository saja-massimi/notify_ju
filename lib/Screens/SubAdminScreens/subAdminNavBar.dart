// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/sharedPref.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminMain.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNotifications.dart';

class subadminNavigationBarWidget extends StatefulWidget {
  const subadminNavigationBarWidget({super.key});

  @override
  State<subadminNavigationBarWidget> createState() =>
      _subadminNavigationBarWidgetState();
}

class _subadminNavigationBarWidgetState extends State<subadminNavigationBarWidget> {

  int notifCount = 0;
 Future<void> _fetchNotifCount() async {
    int notif = SharedPrefController.getNotif('notifs');
    setState(() {
      log('notif: $notif');
      notifCount = notif;
    });
  }
  
@override
  void initState() {
    super.initState();
    _fetchNotifCount();
    SharedPrefController.notifCountStream.listen((count) {
      setState(() {
        notifCount = count;
      });
    });
  }

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
              onPressed: () async{
              final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is currently signed out!');
    } else if(user.email == 'ama0193677@ju.edu.jo') {
      await SharedPrefController.setNotif('notifs', 0);
      await SharedPrefController.setNotif('publicUnitNotif', 0);
      Get.to(subAdminNotifications( reportType:const ['Infrastructural Damage']));  
    }else if(user.email == 'hla0207934@ju.edu.jo'){
          await SharedPrefController.setNotif('notifs', 0);
          await SharedPrefController.setNotif('emergencyUnitNotif', 0);
          Get.to(subAdminNotifications(reportType: const ['Fire','Injury']));
    }else if(user.email == 'gad0200681@ju.edu.jo'){
      await SharedPrefController.setNotif('notifs', 0);
      await SharedPrefController.setNotif('securityUnitNotif', 0);
      Get.to(  subAdminNotifications(reportType: const ['Fight','Stray Animals','Car Accident']));
    
              } },
            icon: Stack(
              children: [
                const Icon(
                  Icons.notification_important_outlined,
                  color: Colors.white,
                ),
                if (notifCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '$notifCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
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
