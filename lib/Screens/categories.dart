import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/add_report.dart';
import 'package:notify_ju/Screens/reportNotification.dart';
import 'package:get/get.dart';
import 'package:notify_ju/bottomNavBar.dart';
import 'package:notify_ju/drawer.dart';

class Categories extends StatelessWidget {
  final List<String> image = [
    'images/fight1.webp',
    'images/tree.png',
  ];

  final List<String> names = [
    'Fight - شجار',
    'Weather Catastrophies - كوارث جوية',
    'Fire - حريق',
    'Theft - سرقة',
    'Car Accident - حادث سيارة',
    'Maintenance accidents - حوادث صيانة',
    'Stray Animals - حيوانات برية',
    'Injury - إصابة'
        'Infrastructure Damage - تلف البنية التحتية',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        backgroundColor: Color.fromARGB(255, 225, 230, 205),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Choose A Category'),
          backgroundColor: const Color.fromARGB(255, 175, 210, 134),
        ),
        body: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                image.length,
                (index) => Container(
                  padding: const EdgeInsets.all(8.0),
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
                      children: [Image.asset(image[index]), Text(names[index])],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBarWidget());
  }
}
