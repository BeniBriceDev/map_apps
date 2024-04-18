import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../src/locations.dart' as locations;

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MapController>(
        builder: (controller) {
          return GoogleMap(
            // onMapCreated: controller.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: controller.latLng,
              zoom: 10,
            ),
            markers: controller.markers.values.toSet(),
          );
        },
      ),
      
    );
  }
}
