// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreenAdmin extends StatefulWidget {
  final GeoPoint selectedLocation;

  const MapScreenAdmin({
    Key? key,
    required this.selectedLocation,
  }) : super(key: key);

  @override
  _MapScreenAdminState createState() => _MapScreenAdminState();
}

class _MapScreenAdminState extends State<MapScreenAdmin> {
  
  late GeoPoint mapSelectedLocation;
  @override
  void initState() {
    mapSelectedLocation = widget.selectedLocation; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(mapSelectedLocation.latitude, mapSelectedLocation.longitude),
          zoom: 15.0,
          
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(mapSelectedLocation.latitude, mapSelectedLocation.longitude),
                builder: (ctx) => Container(
                  child: const Icon(
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
          Navigator.pop(context); 
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
