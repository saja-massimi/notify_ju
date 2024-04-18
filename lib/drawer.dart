import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/profile.dart';
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
            title:const Text('My Profile'),
            onTap: () {
              // Handle My Profile tap
              },
          ),
          ListTile(
            title:const Text('Report History'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ReportsHistoryPage()),
              // );
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              // Handle Contact Us tap
            },
          ),
          ListTile(
            title: const Text('Sign out'),
            onTap: () {
              // Handle Sign out tap
            },
          ),
        ],
      ),
    );
  }
}
