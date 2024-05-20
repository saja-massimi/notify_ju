import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminMap.dart';
import 'package:notify_ju/Screens/AdminScreens/UserData.dart';
import 'package:intl/intl.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNavBar.dart';

class subAdminReportDetails
 extends StatefulWidget {
  final Map<String, dynamic> report;
  const subAdminReportDetails({super.key, required this.report});

  @override
  State<subAdminReportDetails> createState() => _subAdminReportDetailsState();
}

class _subAdminReportDetailsState extends State<subAdminReportDetails> {
  final controller = Get.put(AdminController());
  final List<String> _dropdownItems = [
    'Pending',
    'Under Review',
    'Resolved',
    'On Hold',
    'Rejected',
  ];

  String? _selectedItem;
  void initReportState() {
    _selectedItem = widget.report['report_status'];
  }

  Future<void> _viewImage() async {
    if (widget.report['incident_picture'] == null) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewScreen(
            image: Image.network(widget.report['incident_picture']!)),
      ),
    );
  }

  String _locationMessage = '';

  @override
  void initState() {
    super.initState();
    setLocationName();
    initReportState();
  }

  Future<void> setLocationName() async {
    GeoPoint incidentLocation = widget.report['incident_location'];

    double latitude1 = incidentLocation.latitude;
    double longitude1 = incidentLocation.longitude;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude1, longitude1);
    Placemark? place = placemarks.isNotEmpty ? placemarks[0] : null;
    String address = place != null
        ? "${place.street}, ${place.locality}, ${place.country}"
        : 'Unknown Location';

    setState(() {
      _locationMessage = address.isNotEmpty ? address : 'Unknown Location';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Report Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100.2,
              ),
              TextField(
                enabled: false,
                readOnly: true,
                decoration: const InputDecoration(
                    hintText: 'Report Type : ', filled: true),
                controller:
                    TextEditingController(text: widget.report['report_type']),
              ),
              const SizedBox(
                height: 20.2,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      enabled: false,
                      decoration: const InputDecoration(
                          hintText: 'Address :', filled: true),
                      controller: TextEditingController(text: _locationMessage),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreenAdmin(
                            selectedLocation:
                                widget.report['incident_location'],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20.2,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                readOnly: true,
                maxLines: 5,
                enabled: false,
                controller: TextEditingController(
                    text: widget.report['incident_description']),
                decoration: const InputDecoration(
                  hintText: 'Description : ',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20.2,
              ),
              TextField(
                keyboardType: TextInputType.datetime,
                enabled: false,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'date : ',
                  filled: true,
                ),
                controller: TextEditingController(
                  text: widget.report['report_date'] != null
                      ? DateFormat('yyyy-MM-dd - h:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.report['report_date'].seconds * 1000))
                      : 'No date provided',
                ),
              ),
              const SizedBox(
                height: 20.2,
              ),
              const Text('User\'s Attached Image : '),
              const SizedBox(
                height: 10.2,
              ),
              GestureDetector(
                onTap: _viewImage,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.report['incident_picture'] ??
                          "No Image Provided"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    value: _selectedItem,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: _dropdownItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.changeReportStatus(
                          _selectedItem!,
                          widget.report['report_id'],
                          widget.report['user_email']);
                          Get.snackbar('Success', 'Status Changed Successfully');
                    },

                    child: const Text('Change Status'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(
                      () => userData(userEmail: widget.report['user_email']));
                },
                child: const Text('View User Data'),
              ),
              const SizedBox(
                height: 20.2,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:const  subadminNavigationBarWidget(),
    );
  }
}

class ImageViewScreen extends StatelessWidget {
  final Image image;

  const ImageViewScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}