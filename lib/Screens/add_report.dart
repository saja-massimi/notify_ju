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
import 'package:notify_ju/Widgets/mic.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import '../Widgets/image_input.dart';
import 'package:intl/intl.dart';

class addReport extends StatelessWidget {
  final String reportType;

  const addReport({required this.reportType});
  @override
  Widget build(BuildContext context) {
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
            children: [
              const SizedBox(
                height: 100.2,
              ),
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
              const SizedBox(
                height: 20.2,
              ),
              const TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                enabled: true,
                decoration: InputDecoration(
                  hintText: 'description : ',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20.2,
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
              const ImageInput(),
              const MicInput(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}*/

