// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class IncidentData {
  final String imagePath;
  final String titleTxt;
  final int notificationCount;

  IncidentData({
    required this.imagePath,
    required this.titleTxt,
    required this.notificationCount, 
  });
}
final con = Get.put(AdminController());
// int notif =  con.receveNotification(titleTxt,notificationCount);

List<IncidentData> incidentsList = <IncidentData>[
  IncidentData(
    imagePath: 'images/amanzimgs/fire-truck.png',
    titleTxt: 'Fire',
    notificationCount: con.receveNotification( 'Fire'),
    

  ),
  IncidentData(
    imagePath: 'images/amanzimgs/car-accident.png',
    titleTxt: 'Car Accident',
    notificationCount: con.receveNotification( 'Car Accident'),

  ),
  IncidentData(
    imagePath: 'images/amanzimgs/stretcher.png',
    titleTxt: 'Injury',
    notificationCount: con.receveNotification( 'Injury'),

  ),
  IncidentData(
    imagePath: 'images/amanzimgs/fight.png',
    titleTxt: 'Fight',
    notificationCount: con.receveNotification( 'Fight'),

  ),
  IncidentData(
    imagePath: 'images/amanzimgs/leak.png',
    titleTxt: 'Infrastructural Damage',
    notificationCount: con.receveNotification( 'Infrastructural Damage'),

  ),
  IncidentData(
    imagePath: 'images/amanzimgs/dog.png',
    titleTxt: 'Stray Animals',
    notificationCount: con.receveNotification( 'Stray Animals'),

  ),
];

Widget buildCategoryCard(BuildContext context, IncidentData data) {
  return Container(
    margin: const EdgeInsets.only(bottom: 7),
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
          decoration: const BoxDecoration(),
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
                      if (data.notificationCount > 0) // Display notification circle if there are notifications
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            data.notificationCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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

  AdminMain({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _myKey,
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Stack(
          children: [
            Text(
              'Choose a Category',
              style: TextStyle(color: Colors.white),
            ),
          
          ],
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



