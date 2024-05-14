// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class AdminMain extends StatefulWidget {

    AdminMain({ key,  required this.notifications}) : super(key: key);
    final List<int> notifications;
  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Control Panel',
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
                (index) => Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Incidents(
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
                            width: 100,
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
                    if (widget.notifications[index] > 0)
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            widget.notifications[index].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
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
