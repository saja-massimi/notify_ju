import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Controller/SignupController.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminHistory.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminProfile.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminWarning.dart';

class subsAdminDrawerWidget extends StatelessWidget {
  subsAdminDrawerWidget({super.key});

  Future<String> getName() async {
    final profileData = Get.put(ProfileController());
    return await profileData.getAdminName();
  }

  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final currUser = FirebaseAuth.instance.currentUser!.email;

    String avatarImage = 'assets/images/default_avatar.png';
    if (currUser == 'hla0207934@ju.edu.jo') {
      avatarImage = 'images/amanzimgs/sos.png';
    } else if (currUser == 'gad0200681@ju.edu.jo') {
      avatarImage = 'images/amanzimgs/sec.png';
    } else if (currUser == 'ama0193677@ju.edu.jo') {
      avatarImage = 'images/amanzimgs/publicser.png';
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF464A5E),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      avatarImage,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FutureBuilder<String>(
                  future: getName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      );
                    } else {
                      return const Text(
                        'Unknown',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: () {
              final adminData = Get.put(AdminController());
              final isAdminFuture = adminData.isAdmin();
              Get.to(subsAdminProfile(isAdminFuture: isAdminFuture));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_rounded),
            title: const Text('History Reports'),
            onTap: () {
              final user = FirebaseAuth.instance.currentUser;

              switch (user!.email) {
                case 'ama0193677@ju.edu.jo':
                  Get.to(subAdminHistory(
                      report_type: const ['Infrastructural Damage']));
                  break;
                case 'hla0207934@ju.edu.jo':
                  Get.to(
                      subAdminHistory(report_type: const ['Fire', 'Injury']));
                  break;
                case 'gad0200681@ju.edu.jo':
                  Get.to(subAdminHistory(report_type: const [
                    'Fight',
                    'Stray Animals',
                    'Car Accident'
                  ]));
                  break;
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning_rounded),
            title: const Text('Warnings'),
            onTap: () => Get.to(const subAdminWarnings()),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}
