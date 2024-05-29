import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/sharedPref.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminMain.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNotifications.dart';

class SubadminNavigationBarWidget extends StatefulWidget {
  const SubadminNavigationBarWidget({super.key});

  @override
  State<SubadminNavigationBarWidget> createState() =>
      _SubadminNavigationBarWidgetState();
}

class _SubadminNavigationBarWidgetState extends State<SubadminNavigationBarWidget> {
  int notifCount = 0;

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

  Future<void> _fetchNotifCount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.email == 'ama0193677@ju.edu.jo') {
        notifCount = SharedPrefController.getNotif('publicUnitNotif');
      } else if (user.email == 'hla0207934@ju.edu.jo') {
        notifCount = SharedPrefController.getNotif('emergencyUnitNotif');
      } else if (user.email == 'gad0200681@ju.edu.jo') {
        notifCount = SharedPrefController.getNotif('securityUnitNotif');
      }
    }
    setState(() {});
  }

  Widget getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log('User is currently signed out!');
      return const Center(child: Text('User is signed out'));
    } else if (user.email == 'ama0193677@ju.edu.jo') {
      return const subAdminMain(reportTypes: ['Infrastructural Damage'], adminName: 'Public Services');  
    } else if (user.email == 'hla0207934@ju.edu.jo') {
      return const subAdminMain(reportTypes: ['Fire', 'Injury'], adminName: 'Emergency Services');
    } else if (user.email == 'gad0200681@ju.edu.jo') {
      return const subAdminMain(reportTypes: ['Fight', 'Stray Animals', 'Car Accident'], adminName: 'Security Services');
    } else {
      return const Center(child: Text('Unknown user'));
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
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.email == 'ama0193677@ju.edu.jo') {
                  await SharedPrefController.setNotif('publicUnitNotif', 0);
                  Get.to(const subAdminNotifications(reportType: ['Infrastructural Damage']));
                } else if (user.email == 'hla0207934@ju.edu.jo') {
                  await SharedPrefController.setNotif('emergencyUnitNotif', 0);
                  Get.to(const subAdminNotifications(reportType: ['Fire', 'Injury']));
                } else if (user.email == 'gad0200681@ju.edu.jo') {
                  await SharedPrefController.setNotif('securityUnitNotif', 0);
                  Get.to(const subAdminNotifications(reportType: ['Fight', 'Stray Animals', 'Car Accident']));
                }
              }
              await SharedPrefController.setNotif('notifs', 0);
            },
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
                  builder: (context) => getCurrentUser(),
                ),
              );
            },
            icon: const Icon(Icons.home, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
