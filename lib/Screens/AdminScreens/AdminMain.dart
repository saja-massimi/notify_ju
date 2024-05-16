// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<int> notif = [
    prefs.getInt('fire') ?? 0,
    prefs.getInt('car') ?? 0,
    prefs.getInt('injury') ?? 0,
    prefs.getInt('fight') ?? 0,
    prefs.getInt('infra') ?? 0,
    prefs.getInt('animal') ?? 0,
  ];

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
  late Future<List<int>> _notificationCountsFuture;

  @override
  void initState() {
    super.initState();
    _notificationCountsFuture = getNotifCount();
  }

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
          future: _notificationCountsFuture,
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
                  notificationCount:
                      notificationCounts.isNotEmpty ? notificationCounts[0] : 0,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/car-accident.png',
                  titleTxt: 'Car Accident',
                  notificationCount:
                      notificationCounts.length > 1 ? notificationCounts[1] : 0,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/stretcher.png',
                  titleTxt: 'Injury',
                  notificationCount:
                      notificationCounts.length > 2 ? notificationCounts[2] : 0,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/fight.png',
                  titleTxt: 'Fight',
                  notificationCount:
                      notificationCounts.length > 3 ? notificationCounts[3] : 0,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/leak.png',
                  titleTxt: 'Infrastructural Damage',
                  notificationCount:
                      notificationCounts.length > 4 ? notificationCounts[4] : 0,
                ),
                IncidentData(
                  imagePath: 'images/amanzimgs/dog.png',
                  titleTxt: 'Stray Animals',
                  notificationCount:
                      notificationCounts.length > 5 ? notificationCounts[5] : 0,
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
