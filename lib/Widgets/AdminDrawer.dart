import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Controller/SignupController.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminProflie.dart';
import 'package:notify_ju/Screens/AdminScreens/HistoryReports.dart';
import 'package:notify_ju/Screens/AdminScreens/stats.dart';
import 'package:notify_ju/Screens/AdminScreens/warningsPage.dart';

class AdminDrawerWidget extends StatelessWidget {
  AdminDrawerWidget({super.key});

  Future<String> getName() async {
    final profileData = Get.put(ProfileController());

    return await profileData.getAdminName();
  }

  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
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
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  child: ClipOval(
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Color.fromARGB(255, 215, 212, 212),
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
              Get.to(() => ProfileWidget(isAdminFuture: isAdminFuture));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_rounded),
            title: const Text('History Reports'),
            onTap: () => Get.to(() => const HistoryReportsAdmin()),
          ),
          ListTile(
            leading: const Icon(Icons.warning_rounded),
            title: const Text('Warnings'),
            onTap: () => Get.to(() => const Warnings()),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statistics'),
            onTap: () => Get.to(() => const stats()),
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
