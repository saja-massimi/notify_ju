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
    'Fight ',
    'Fire ',
    'Theft ',
    'Car Accident - حادث سيارة',
    'Stray Animals - حيوانات ضالة',
    'Injury - إصابة'
        'Infrastructure Damage - تلف البنية التحتية',
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF69BE49),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white),
          ],
          selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          onTap: (int index) {
            if (index == 0) {
              Get.to(const ReportNotification());
            } else if (index == 1) {
              Get.to(Categories());
            }
          },
        ));
  }
}
