import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Controller/signupController.dart';
import 'package:notify_ju/Screens/contact.dart';
import 'package:notify_ju/Screens/profile.dart';
import 'package:notify_ju/Screens/reportHistory.dart';


class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  Future<String> getName() async {
  final profileData = Get.put(ProfileController());
  final adminData = Get.put(AdminController());
  final isAdmin = await adminData.isAdmin();
  if (isAdmin) {
    return await profileData.getAdminName();
  } else {
    return await profileData.getUserName();
  }
}


  final controller = Get.put(SignupController());
  final controllerprof = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF69BE49), 
            ),
        child: Row(
  children: [
    CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: Image.asset(
          'images/logopng.png',
          fit: BoxFit.cover, 
          width: 80, 
          height: 80, 
        ),
      ),
    ),
    const SizedBox(width: 10),
    FutureBuilder<String>(
      future: getName(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
            return Text(
            snapshot.data!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            );
            }
            else {
            return const Text(
            'Unknown',
            style: TextStyle(color: Colors.white, fontSize: 16),
            );
            }
      },
    ),
    const SizedBox(height: 10),
  ],
),

          ),
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              final adminData = Get.put(AdminController());
              final isAdminFuture = adminData.isAdmin();
              Get.to(ProfileWidget(isAdminFuture: isAdminFuture));
                  },
          ),
          ListTile(
            title: const Text('Report History'),
            onTap: () {
              Get.to(() => const HistoryReports());
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              Get.to(() => contact_us());
            },
          ),
          ListTile(
            title: const Text('Sign out'),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}
