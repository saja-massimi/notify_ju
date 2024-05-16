import 'package:flutter/material.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({Key? key}) : super(key: key);

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
      ),
      body: const Center(
        child: Text("You don't have any notifications yet"),
      ),
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
