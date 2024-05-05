import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/myReports.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidget();
}

class _BottomNavigationBarWidget extends State<BottomNavigationBarWidget> {
  int currentIndex = 0;
  bool isTapped = false;
  final screen = [Categories(), MyReports()];
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: [
        Icon(
          Icons.home,
          color: isTapped && currentIndex == 0
              ? Color.fromARGB(255, 255, 255, 255)
              : Colors.black,
        ),
        Icon(
          Icons.notifications,
          color: isTapped && currentIndex == 1
              ? Color.fromARGB(255, 255, 255, 255)
              : Colors.black,
        ),
      ],
      backgroundColor: Colors.transparent,
      index: currentIndex,
      animationDuration: const Duration(milliseconds: 200),
      color: const Color.fromARGB(255, 195, 235, 197),
      onTap: (index) {
        setState(() {
          currentIndex = index;
          isTapped = true;
        });
      },
    );
  }
}
