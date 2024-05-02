import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/signupController.dart';
import 'package:notify_ju/Screens/contact.dart';
import 'package:notify_ju/Screens/profile.dart';
import 'package:notify_ju/Screens/reportHistory.dart';


class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF69BE49), 
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              Get.to(ProfileWidget());
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
