import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:notify_ju/Controller/sharedPref.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminNotifications.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminMain.dart';
import 'package:notify_ju/Screens/AdminScreens/adminpostscreen.dart';

class AdminNavigationBarWidget extends StatefulWidget {
  const AdminNavigationBarWidget({super.key});

  @override
  State<AdminNavigationBarWidget> createState() =>
      _AdminNavigationBarWidgetState();
}


class _AdminNavigationBarWidgetState extends State<AdminNavigationBarWidget> {
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
    int notif = SharedPrefController.getNotif('notifs');

    setState(() {
      log('notif: $notif');
      notifCount = notif;
    });
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminNotifications()));
              await SharedPrefController.setNotif('notifs', 0);

          
              

            },
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications,
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
                    builder: (context) => const AdminMain(),
                  ));
            },
            icon: const Icon(Icons.category, color: Colors.white),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminPostsScreen()));
            },
            icon: const Icon(Icons.book, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
