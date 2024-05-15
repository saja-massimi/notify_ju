// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class IncidentData {
  final String imagePath;
  final String titleTxt;

  IncidentData({
    required this.imagePath,
    required this.titleTxt,
  });
}

List<IncidentData> incidentsList = <IncidentData>[
  IncidentData(
    imagePath: 'images/amanzimgs/fire-truck.png',
    titleTxt: 'Fire',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/car-accident.png',
    titleTxt: 'Car Accident',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/stretcher.png',
    titleTxt: 'Injury',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/fight.png',
    titleTxt: 'Fight',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/leak.png',
    titleTxt: 'Infrastructural Damage',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/dog.png',
    titleTxt: 'Stray Animals',
  ),
];

Widget buildCategoryCard(BuildContext context, IncidentData data) {
  return Container(
    margin: EdgeInsets.only(bottom: 7),
    height: 135,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Incidents(
                reportType: data.titleTxt,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  data.imagePath,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.titleTxt,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class AdminMain extends StatefulWidget {
  const AdminMain({key, required this.notifications}) : super(key: key);
  final List<int> notifications;
  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  late GlobalKey _myKey;
  @override
  void initState() {
    super.initState();
    _myKey = GlobalKey();
  }

  final List<int> notifications = [2, 0, 5, 0, 0, 3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _myKey,
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Choose a Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: incidentsList.length,
          itemBuilder: (context, index) {
            return buildCategoryCard(context, incidentsList[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}



/*// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class AdminMain extends StatefulWidget {
///////////////////////////////
  AdminMain({key, required this.notifications}) : super(key: key);
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

  final List<int> notifications = [
    2,
    0,
    5,
    0,
    0,
    3
  ]; // Sample notifications, replace with actual data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Control Panel',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF464A5E),
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
*/