import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/categories.dart';

class ReportNotification extends StatelessWidget {
  const ReportNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 210, 134),
      appBar: AppBar(
        title: const Center(child: Text('Report Notification')),
        backgroundColor: const Color.fromARGB(255, 175, 210, 134),
      ),
      body: const Column(
        children: [
          SizedBox(
            width: 500,
            height: 200.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Report 1. Car Accident at Faculaty of Medicine',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ),
          SizedBox(
            width: 500,
            height: 200.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Report 1. Car Accident at Faculaty of Medicine',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'notifications',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white),
        ],
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportNotification()),
            );
          } else if (index == 1) {
            // Replace `HomePage` with the desired home page widget
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Categories()),
            );
          }
        },
      ),
    );
  }
}
