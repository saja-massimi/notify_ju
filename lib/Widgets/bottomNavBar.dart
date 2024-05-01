import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/myReports.dart';

// ignore: use_key_in_widget_constructors


class BottomNavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green.withOpacity(0.1), 
            Colors.green.withOpacity(0.5), 
          ],
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Apply blur effect
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.white),
                label: 'My Reports',
              ),
            ],
            onTap: (int index) {
              if (index == 0) {
                Get.to(() => Categories());
              } else {
                Get.to(() => const MyReports());
              }
            },
            backgroundColor: Colors.transparent, 
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
