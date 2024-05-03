import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  LatLng selectedLocation;
  final Function(LatLng) onLocationSelected;

  MapScreen({
    Key? key,
    required this.selectedLocation,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng mapSelectedLocation;
  @override
  void initState() {
    mapSelectedLocation = widget.selectedLocation; //changes the marker
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: mapSelectedLocation,
          zoom: 15.0,
          onTap: (TapPosition tapPosition, LatLng location) {
            setState(() {
              mapSelectedLocation = location;
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
                point: mapSelectedLocation,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Go back to the previous screen
          print(mapSelectedLocation);
          widget.onLocationSelected(
              mapSelectedLocation); //bring the value to the etxt field
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
