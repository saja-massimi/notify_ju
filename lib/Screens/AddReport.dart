import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Models/reportModel.dart';
import 'package:notify_ju/Widgets/mic.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:notify_ju/Screens/MapScreen.dart';

class addReport extends StatefulWidget {
  final String reportType;

  addReport({Key? key, required this.reportType}) : super(key: key);

  @override
  _addReportState createState() => _addReportState();
}

class _addReportState extends State<addReport> {
  final description = TextEditingController();
  final addressz = TextEditingController();
  String _locationMessage = '';
  LatLng _selectedLocation = const LatLng(32.0161, 35.8695);
  bool showMap = false;
//********************************************************** */

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    addressz.clear();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String address = "${place.name}, ${place.locality}, ${place.country}";
      setState(() {
        addressz.clear();
        _locationMessage = address;
        addressz.clear();
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportsController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Report', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF69BE49),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                enabled: false,
                readOnly: true,
                decoration: const InputDecoration(
                    hintText: 'Report Type : ', filled: true),
                controller: TextEditingController(text: widget.reportType),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      enabled: true,
                      decoration:
                          const InputDecoration(hintText: 'Address :', filled: true),
                      controller: addressz..text = _locationMessage,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () async {
                      LatLng selectedLocation = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            selectedLocation:
                                _selectedLocation, // Pass your selected location here
                            onLocationSelected: (location) {
                              setState(() async {
                                _selectedLocation = location;
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        location.latitude, location.longitude);
                                Placemark? place = placemarks.isNotEmpty
                                    ? placemarks[0]
                                    : null;
                                String address = place != null
                                    ? "${place.street}, ${place.locality}, ${place.country}"
                                    : 'Unknown Location';
                                setState(() {
                                  _locationMessage = address;
                                });
                              });
                              Navigator.pop(context,
                                  location); // Pop the map screen and return the selected location
                            },
                          ),
                        ),
                      );
                      setState(() {
                        _selectedLocation = selectedLocation;
                      });
                                        },
                  ),
                ],
              ),

              ////////////////////////////////////////////////////////////////////////
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                enabled: true,
                controller: description,
                decoration: const InputDecoration(
                  hintText: 'Description : ',
                  filled: true,
                ),
              ),

              TextField(
                keyboardType: TextInputType.datetime,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: 'date : ',
                  filled: true,
                ),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd - h:mm').format(DateTime.now()),
                ),
              ),

              const MicInput(),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  final report = reportModel(
                    report_id: randomAlphaNumeric(20),
                    report_type: widget.reportType,
                    incident_description: description.text,
                    report_date: DateTime.now(),
                    report_status: 'Pending',
                  );
                  controller.createReport(report);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
