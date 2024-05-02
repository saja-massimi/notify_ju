<<<<<<< HEAD:lib/Screens/add_report.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notify_ju/Widgets/mic.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddReportPage extends StatefulWidget {
  final String reportType;

  const AddReportPage({Key? key, required this.reportType}) : super(key: key);

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  String _locationMessage = '';
  LatLng _selectedLocation = LatLng(32.0161, 35.8695);
  bool showMap = false;

  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String address = "${place.name}, ${place.locality}, ${place.country}";
      setState(() {
        _locationMessage = address;
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    }
  }

  Widget _buildFormWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 100.0),
          TextField(
            enabled: false,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Report Type : ',
              filled: true,
            ),
            controller: TextEditingController(text: widget.reportType),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: 'Address :',
                    filled: true,
                  ),
                  controller: TextEditingController(text: _locationMessage),
                ),
              ),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () async {
                  setState(() {
                    showMap = true; // Show the map when button is pressed
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            enabled: true,
            decoration: InputDecoration(
              hintText: 'Description : ',
              filled: true,
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            keyboardType: TextInputType.datetime,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Date : ',
              filled: true,
            ),
            controller: TextEditingController(
              text: DateFormat('yyyy-MM-dd - h:mm').format(DateTime.now()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: _selectedLocation,
              zoom: 15.0,
              onTap: (TapPosition tapPosition, LatLng location) {
                setState(() {
                  _selectedLocation = location;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: _selectedLocation,
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  showMap = false; // Hide the map when button is pressed
                });
              },
              child: Icon(Icons.check),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${widget.reportType} Report'),
      ),
      body: showMap ? _buildMapWidget() : _buildFormWidget(),
    );
  }
}


















/*import 'package:flutter/material.dart';
=======
// ignore_for_file: camel_case_types



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Models/reportModel.dart';
>>>>>>> a7f691c10051f976a4553c9274ef12e2f7cd7173:lib/Screens/AddReport.dart
import 'package:notify_ju/Widgets/mic.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class addReport extends StatelessWidget {
  final String reportType;
  final description = TextEditingController();

  addReport({super.key, required this.reportType});
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
                controller: TextEditingController(text: reportType),
              ),
              const SizedBox(
                height: 20.2,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      enabled: true,
                      decoration:
                          InputDecoration(hintText: 'Address :', filled: true),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      // TODO: Implement location picker
                    },
                  ),
                ],
              ),
        
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

                  final report = reportModel(
                  report_id: randomAlphaNumeric(20),
                  report_type: reportType, 
                  incident_description: description.text,
                  report_date: DateTime.now(),
                  report_status: 'History',
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
}*/

