// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/WarningsController.dart';
import 'package:notify_ju/Controller/subAdminsController.dart';
import 'package:notify_ju/Models/warningModel.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminAllReportsType.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminDrawer.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNavBar.dart';
import 'package:random_string/random_string.dart';

class IncidentData {
  final String imagePath;
  final String titleTxt;
  final String description;

  IncidentData({
    required this.imagePath,
    required this.titleTxt,
    required this.description,
  });
}

List<IncidentData> incidentsList = <IncidentData>[
  IncidentData(
    imagePath: 'images/amanzimgs/fire-truck.png',
    titleTxt: 'Fire',
    description:
        'Report fire outbreaks or hazards on campus for immediate action.',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/car-accident.png',
    titleTxt: 'Car Accident',
    description: 'Report vehicle incidents on campus for prompt action.',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/stretcher.png',
    titleTxt: 'Injury',
    description:
        'Report campus injuries promptly for swift medical assistance.',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/fight.png',
    titleTxt: 'Fight',
    description:
        'Report physical conflicts on campus for immediate intervention',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/leak.png',
    titleTxt: 'Infrastructural Damage',
    description:
        'Report damage to campus property or equipment for quick repairs.',
  ),
  IncidentData(
    imagePath: 'images/amanzimgs/dog.png',
    titleTxt: 'Stray Animals',
    description:
        'Report sightings of stray animals for appropriate handling and safety measures',
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
              builder: (context) => subAdminIncidents(
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
                      Text(
                        data.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
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

class subAdminMain extends StatefulWidget {
  const subAdminMain({super.key, required this.reportTypes, required this.adminName});
  final List<String> reportTypes;
  final String adminName;
  @override
  _subAdminMainState createState() => _subAdminMainState();
}

class _subAdminMainState extends State<subAdminMain> {
  final sub = Get.put(SubAdminsController());
  final ad = Get.put(AdminController());
  late GlobalKey _myKey;

  @override
  void initState() {
    super.initState();
    _myKey = GlobalKey();
    _initialize();
  }

  void _initialize() async {

    List<dynamic> reps = [];
    final currUser = FirebaseAuth.instance.currentUser!.email;
    switch (currUser) {
      case 'hla0207934@ju.edu.jo':
        reps = await ad.getReportStatus('Pending', ['Fire', 'Injury']);
        break;
      case 'gad0200681@ju.edu.jo':
        reps = await ad.getReportStatus('Pending', ['Car Accident', 'Fight', 'Stray Animals']);
        break;
      case 'ama0193677@ju.edu.jo':
        reps = await ad.getReportStatus('Pending', ['Infrastructural Damage']);
        break;
      default:
        break;
    }
log('reps: $reps');
    final war = Get.put(WarningsController());

    for (var report in reps) {
      DateTime reportDate = (report['report_date'] as Timestamp).toDate(); 
      if (DateTime.now().difference(reportDate) > const Duration(minutes: 5)) {
        final rand = randomAlphaNumeric(20);
        final model = WarningModel(
          id: rand,
          subAdminEmail: currUser!,
          message: "You have not responded to the report for more than 5 hours",
          timestamp: DateTime.now(),
        );
        ad.changeReportStatus('On Hold', report['report_id'], report['user_email']);
        war.createWarning(model);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _myKey,
      drawer: subsAdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.adminName} Admin Dashboard',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.reportTypes.length,
          itemBuilder: (context, index) {
            for (var i = 0; i < incidentsList.length; i++) {
              if (incidentsList[i].titleTxt == widget.reportTypes[index]) {
                return buildCategoryCard(context, incidentsList[i]);
              }
            }
            return const SizedBox(); // Handle unmatched case
          },
        ),
      ),
      bottomNavigationBar: const subadminNavigationBarWidget(),
    );
  }
}
