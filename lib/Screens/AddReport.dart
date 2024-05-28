// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/SendNotificationController.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Models/reportModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Widgets/image_input.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:notify_ju/Screens/MapScreen.dart';

class addReport extends StatefulWidget {
  final String reportType;
  final _authRepo = Get.put(AuthenticationRepository());

  addReport({super.key, required this.reportType});

  @override
  _addReportState createState() => _addReportState();
}

class _addReportState extends State<addReport> {
  final description = TextEditingController();
  final addressz = TextEditingController();
  String _locationMessage = '';
  LatLng _selectedLocation = const LatLng(32.0161, 35.8695);
  bool showMap = false;
  String? _imageUrl;
  final notif = Get.put(SendNotification());
  @override
  void initState() {
    super.initState();
    getPermission();
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
        _locationMessage = address;
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    }
  }

 getPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Get.rawSnackbar(
      title: "Warning",
      messageText: const Text("You must enable location service "),
    );
    return;
  }

  // Check for existing location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.rawSnackbar(
        title: "Warning",
        messageText: const Text("You must allow Location Permission to use this feature "),
      );
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Get.rawSnackbar(
      title: "Warning",
      messageText: const Text("Location permisssions are permanently denied, we cannot request permissions."),
    );
    return;
  }

  if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
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
          title:
              const Text('Add Report', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF464A5E),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined,
                  color: Colors.white),
              onPressed: () {
                Get.back();
              })),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      enabled: false,
                      decoration: const InputDecoration(
                          hintText: 'Address :', filled: true),
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
                            selectedLocation: _selectedLocation,
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
                              Navigator.pop(context, location);
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
              ImageInput(
                onImageSelected: (imageUrl) {
                  setState(() {
                    _imageUrl = imageUrl;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final ad = Get.put(AdminController());
                      if(description.text=="" && _imageUrl==null){
                        Get.rawSnackbar(
                            title: "Warning",
                            messageText: const Text("Please fill the description or add a picture"));
                        return;
                      }
                      final rand = randomAlphaNumeric(20);
                      final report = reportModel(
                        report_id: rand,
                        report_type: widget.reportType,
                        incident_description: description.text,
                        report_date: DateTime.now(),
                        report_status: 'Pending',
                        incident_location: GeoPoint(_selectedLocation.latitude,
                            _selectedLocation.longitude),
                        user_email: widget._authRepo.firebaseUser.value?.email,
                        incident_picture: _imageUrl,
                      );
                      if(!await controller.canSubmitSpam()){
                        Get.rawSnackbar(
                            title: "Warning",
                            messageText: const Text("Spam detected, you should wait 30 seconds to submit a report"));
                            return;
                      }

                      if(!await controller.canSubmitReport()){
                        Get.rawSnackbar(
                            title: "Warning",
                            messageText: const Text("You reached the maximum number of reports"));
                            return;
                      }
                      Get.back();
                      await notif.sendNotification('A new report', 'A new report has been sent', report);
                      
                      if(_imageUrl!=null){
                      if(await controller.areImagesSame(_imageUrl!) ){
                      ad.changeReportStatus('Rejected', rand, widget._authRepo.firebaseUser.value!.email!);
                      }}
                      else 
                      if(await controller.areDescriptionsSame(description.text)){
                      ad.changeReportStatus('Rejected', rand, widget._authRepo.firebaseUser.value!.email!);
                      
                      }
                    await controller.createReport(report);

                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
