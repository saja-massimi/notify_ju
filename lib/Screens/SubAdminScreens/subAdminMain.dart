// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/AddReport.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

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
              builder: (context) => addReport(
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
  subAdminMain({super.key, required this.reportTypes, required this.adminName});
  List<String> reportTypes;
  String adminName;
  @override
  _subAdminMainState createState() => _subAdminMainState();
}

class _subAdminMainState extends State<subAdminMain> {
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
            return null;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
