// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AddReport.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class Categories extends StatelessWidget {
  final List<String> image = [
    'images/fight123.jpg',
    'images/fiire.webp',
    'images/carss.png',
    'images/doggg.png',
    'images/injuryy.png',
    'images/infraa.png',
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
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontStyle: FontStyle.italic)),
        backgroundColor: const Color.fromARGB(255, 195, 235, 197),
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
                          height: 110,
                          child: Image.asset(image[index],
                              fit: BoxFit.fitHeight,
                              scale: 1.0,
                              alignment: Alignment.center),
                        ),
                        const SizedBox(height: 15),
                        Text(names[index],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
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
