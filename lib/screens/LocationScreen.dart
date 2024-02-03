import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/widgets/map_Screen.dart';
import 'package:travel_app/widgets/home_bottom_bar.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;

//_HomeBottomBarState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 450,
          height: 700,
          child: MapScreen(
            initialLatitude: 41.015137,
            initialLongitude: 28.979530,
            initialzoom: 12.0,
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}
