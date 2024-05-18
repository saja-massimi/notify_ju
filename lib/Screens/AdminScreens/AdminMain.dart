// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api, await_only_futures

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';

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
    margin: const EdgeInsets.only(bottom: 7),
    height: 135,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        onTap: () async {
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
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
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
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
