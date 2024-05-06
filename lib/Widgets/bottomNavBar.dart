import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/myReports.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int currentIndex = 0;
  final screen = [Categories(), const MyReports()];

  @override
  Widget build(BuildContext context) {
    return GNav(
      backgroundColor: const Color.fromARGB(255, 195, 235, 197),
      activeColor: Color.fromARGB(255, 136, 135, 135),
      color: Colors.white,
      gap: 3,
      selectedIndex: currentIndex,
      onTabChange: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      tabs: [
        GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Categories(),
                ),
              );
            }),
        GButton(
          icon: Icons.notifications,
          text: 'My Reports',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyReports(),
              ),
            );
          },
        ),
      ],
    );
  }
}
