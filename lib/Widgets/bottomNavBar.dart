import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/categories.dart';

// ignore: use_key_in_widget_constructors
class BottomNavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Colors.white),
          label: 'Notifications',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          Get.to(() => Categories());
        }
      },
      backgroundColor: const Color(0xFF69BE49),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    );
  }
}
