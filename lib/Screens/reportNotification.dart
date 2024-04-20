import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/bottomNavBar.dart';

class ReportNotification extends StatelessWidget {
  const ReportNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Report History', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF69BE49),
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 500,
            height: 100.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 203, 203, 203),
              ),
              child: Text(
                'Report 1. Car Accident at Faculaty of Medicine',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 500,
            height: 100.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 203, 203, 203),
              ),
              child: Text(
                'Report 2. Car Accident at Faculaty of Medicine',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
