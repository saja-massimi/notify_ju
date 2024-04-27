// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/add_report.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class Categories extends StatelessWidget {
  final List<String> image = [
    'images/fight1.webp',
    'images/fire.png',
    'images/car.png',
    'images/animal.png',
    'images/injury.png',
    'images/damage.webp',
  ];

  final List<String> names = [
    'Fight',
    'Fire',
    'Car Accident',
    'Stray Animals',
    'Injury',
    'Infrastructure Damage',
  ];

  Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Choose a Category',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF69BE49),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              clipBehavior: Clip.antiAlias,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                image.length,
                (index) => Container(
                  padding: const EdgeInsets.all(3),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                      const SizedBox(height: 15),
                        Container(
                          height: 70,
                          child: Image.asset(image[index],
                              fit: BoxFit.fitHeight,
                              scale: 1.0,
                              alignment: Alignment.center),
                        ),
                        const SizedBox(height: 15),
                        Text(names[index],
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center),
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
