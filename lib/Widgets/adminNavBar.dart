import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminNotifications.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminVoting.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminMain.dart';

class AdminNavigationBarWidget extends StatefulWidget {
  const AdminNavigationBarWidget({super.key});

  @override
  State<AdminNavigationBarWidget> createState() =>
      _AdminNavigationBarWidgetState();
}

class _AdminNavigationBarWidgetState extends State<AdminNavigationBarWidget> {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminNotifications()));
              },
              icon: const Icon(Icons.notification_important_outlined,
                  color: Colors.white),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminMain(),
                      ));
                },
                icon: const Icon(Icons.category, color: Colors.white)),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminVoting()));
                },
                icon: const Icon(Icons.people, color: Colors.white)),
          ],
        ));
  }
}
