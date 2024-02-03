import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;
  final double initialzoom;
  MapScreen(
      {required this.initialLatitude,
      required this.initialLongitude,
      required this.initialzoom});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLatitude, widget.initialLongitude),
          zoom: widget.initialzoom,
        ),
        markers: {
          Marker(
            markerId: MarkerId('customMarker'),
            position: LatLng(widget.initialLatitude, widget.initialLongitude),
            infoWindow: InfoWindow(title: 'Konum'),
          ),
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapScreen(
        initialLatitude: 41.015137,
        initialLongitude: 28.979530,
        initialzoom: 12),
  ));
}
