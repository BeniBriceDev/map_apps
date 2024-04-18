import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/gps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GpsApp extends StatelessWidget {
  const GpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GpsController>(
        builder: (controller) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: controller.destination,
              zoom: 13.5,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('source'),
                position: controller.sourceDestination,
              ),
              Marker(
                markerId: const MarkerId('destination'),
                position: controller.destination,
              ),
            },
            onMapCreated: (mapController) {
              controller.controller.complete(mapController);
            },
          );
        },
      ),
    );
  }
}
