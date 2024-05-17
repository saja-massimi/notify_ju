// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Models/reportModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:notify_ju/Screens/MapScreen.dart';
import 'package:notify_ju/Widgets/image_input.dart';

class EditReport extends StatefulWidget {
  final Map<String, dynamic> report;
  final _authRepo = Get.put(AuthenticationRepository());
  EditReport({Key? key, required this.report}) : super(key: key);

  @override
  _EditReportState createState() => _EditReportState();
}

class _EditReportState extends State<EditReport> {
  final description = TextEditingController();
  final addressz = TextEditingController();
  String _locationMessage = '';
  LatLng _selectedLocation = const LatLng(32.0161, 35.8695);
  bool showMap = false;
  String? _imageUrl;
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

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.rawSnackbar(
          title: "Warning",
          messageText: const Text("you must enable location service "));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.rawSnackbar(
            title: "Warning",
            messageText: const Text(
                "You must allow Location Permission to use this feature "));
        return;
      } else if (permission == LocationPermission.whileInUse) {
        await getPermission();
      }
    } else if (permission == LocationPermission.whileInUse) {
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
          title: const Text('Edit Report',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontStyle: FontStyle.italic)),
          backgroundColor: const Color.fromARGB(255, 195, 235, 197),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
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
                controller:
                    TextEditingController(text: widget.report['report_type']),
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
                controller: description
                  ..text = widget.report['incident_description'],
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
                      image: NetworkImage(widget.report['incident_picture']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 19.9),
              ImageInput(
                onImageSelected: (imageUrl) {
                  setState(() {
                    _imageUrl = imageUrl;
                  });
                },
              ),
              const SizedBox(height: 19.9),
              const Text('Report Status: '),
              TextField(
                keyboardType: TextInputType.multiline,
                readOnly: true,
                decoration: const InputDecoration(
                    hintText: 'Report Status : ', filled: true),
                controller:
                    TextEditingController(text: widget.report['report_status']),
              ),
              const SizedBox(
                height: 20.2,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final report = reportModel(
                        report_id: widget.report['report_id'],
                        report_type: widget.report['report_type'],
                        incident_description: description.text,
                        report_date: DateTime.now(),
                        report_status: widget.report['report_status'],
                        incident_location: GeoPoint(_selectedLocation.latitude,
                            _selectedLocation.longitude),
                        user_email: widget._authRepo.firebaseUser.value?.email,
                        incident_picture:
                            _imageUrl ?? widget.report['incident_picture'],
                      );

                      controller.updateReport(
                          widget.report['report_id'], report);
                      Get.back();
                    },
                    child: const Text('Update'),
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
      bottomNavigationBar: AdminNavigationBarWidget(),
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
                Get.back();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
