import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/myReports.dart';
import 'package:notify_ju/Screens/pageVote.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Categories()));
              },
              icon: const Icon(Icons.home, color: Colors.white),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Categories()));
                },
                icon: const Icon(Icons.category, color: Colors.white)),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyReports()));
                },
                icon: const Icon(Icons.description, color: Colors.white)),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const VotingPage1()));
                },
                icon: const Icon(Icons.people, color: Colors.white)),
          ],
        ));
  }
}
