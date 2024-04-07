import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/add_report.dart';
import 'package:notify_ju/Screens/reportNotification.dart';

class Categories extends StatelessWidget {
  final List<String> image = [
    'images/fight.webp',
    'images/tree.png',
  ];

  final List<String> names = [
    'Fight',
    'Tree',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 175, 210, 134),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 132, 60),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Choose a category',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
                      children: <Widget>[
                        Image.asset(image[index]),
                        Text(names[index]),
                      ],
                    ),
                  ),
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
        ));
  }
}
