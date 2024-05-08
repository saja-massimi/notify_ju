import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/myReports.dart';
import 'package:notify_ju/Screens/votes.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: const Color.fromARGB(255, 195, 235, 197),
        shape: const CircularNotchedRectangle(),
        notchMargin: 50,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories()));
              },
              icon: Icon(Icons.home),
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyReports()));
                },
                icon: Icon(Icons.notifications)),
            Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VotingPage()));
                },
                icon: Icon(Icons.people)),
          ],
        ));
  }
}
