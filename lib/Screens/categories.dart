import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/add_report.dart';
import 'package:notify_ju/Screens/reportNotification.dart';
import 'package:get/get.dart';
import 'package:notify_ju/bottomNavBar.dart';
import 'package:notify_ju/drawer.dart';

class Categories extends StatelessWidget {
  final List<String> image = [
    'images/fight1.webp',
    'images/fire.png',
    'images/Theft.png',
    'images/car.png',
    'images/animal.png',
    'images/injury.png',
    'images/damage.webp',
  ];

  final List<String> names = [
    'Fight',
    'Fire',
    'Theft',
    'Car Accident',
    'Stray Animals',
    'Injury',
    'Infrastructure Damage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Choose A Category'),
        backgroundColor: Color(0xFF69BE49),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                image.length,
                (index) => Container(
                  padding: const EdgeInsets.all(6.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => addReport(
                            reportType: names[index],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(image[index], fit: BoxFit.cover),
                        ),
                        Text(names[index]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
