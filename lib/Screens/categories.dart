import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/add_report.dart';
import 'package:notify_ju/bottomNavBar.dart';
import 'package:notify_ju/drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Choose A Category',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF69BE49),
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
                        SizedBox(height: 15),
                        Container(
                          height: 100,
                          // Adjust height to desired size
                          child: Image.asset(image[index],
                              fit: BoxFit.fitHeight,
                              scale: 1.0,
                              alignment: Alignment.center),
                        ),
                        SizedBox(height: 15),
                        Text(names[index],
                            style: TextStyle(fontSize: 16),
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
