// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notify_ju/Controller/sharedPref.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';

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

Future<List<int>> getNotifCount() async {

  List<int> notif = [
    await SharedPrefController.getNotif('fire'),
    await SharedPrefController.getNotif('car'),
    await SharedPrefController.getNotif('injury'),
    await SharedPrefController.getNotif('fight'),
    await SharedPrefController.getNotif('infra'),
    await SharedPrefController.getNotif('animal'),

  ];

log(notif.toString());
  return notif;
}

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
        onTap: () async{

switch (data.titleTxt) {
    case 'Fire':
        await SharedPrefController.setNotif('fire', 0);
      break;
    case 'Car Accident':
            await SharedPrefController.setNotif('car', 0);
      break;
    case 'Injury':
        await SharedPrefController.setNotif('injury', 0);
      break;
    case 'Fight':
            await SharedPrefController.setNotif('fight', 0);
      break;
    case 'Infrastructural Damage':
            await SharedPrefController.setNotif('infra', 0);
      break;
    case 'Stray Animals':
            await SharedPrefController.setNotif('fight', 0);
      break;
    default:
      log('Unknown notification received');
  }
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
                      if (data.notificationCount > 0)
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
  const AdminMain({Key? key}) : super(key: key);

  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
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
        child: FutureBuilder<List<int>>(
          future: getNotifCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<int> notificationCounts = snapshot.data ?? [];
              List<IncidentData> incidentsList = [
                IncidentData(
                  imagePath: 'images/amanzimgs/fire-truck.png',
                  titleTxt: 'Fire',
                  notificationCount:notificationCounts[0],
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/car-accident.png',
                  titleTxt: 'Car Accident',
                  notificationCount:
                    notificationCounts[1] ,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/stretcher.png',
                  titleTxt: 'Injury',
                  notificationCount:
                  notificationCounts[2] ,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/fight.png',
                  titleTxt: 'Fight',
                  notificationCount:
                    notificationCounts[3] ,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/leak.png',
                  titleTxt: 'Infrastructural Damage',
                  notificationCount:
              notificationCounts[4] ,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/dog.png',
                  titleTxt: 'Stray Animals',
                  notificationCount:
                    notificationCounts[5] ,
                ),
              ];

              return ListView.builder(
                itemCount: incidentsList.length,
                itemBuilder: (context, index) {
                  return buildCategoryCard(context, incidentsList[index]);
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
