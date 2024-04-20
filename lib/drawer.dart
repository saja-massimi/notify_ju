import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/contact.dart';
import 'package:notify_ju/Screens/email_auth.dart';
import 'package:notify_ju/Screens/profile.dart';
import 'package:notify_ju/Screens/reportNotification.dart';
// import 'Screens/reportsHistory.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF69BE49), // Set the drawer header color
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              Get.to(() => ProfileWidget());
            },
          ),
          ListTile(
            title: const Text('Report History'),
            onTap: () {
              Get.to(() => ReportNotification());
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
            onTap: () {
              Get.to(() => email_auth());
            },
          ),
        ],
      ),
    );
  }
}
