import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LandingContoller extends GetxController {
  final isFirstRun = Rx<bool>(true);
  final _currentAdress = ''.obs;
  final latitude = Rx<double?>(0.0);
  final longitude = Rx<double?>(0.0);

  final stateLatitude = Rx<double?>(0.0);
  final stateLongitude = Rx<double?>(0.0);
  final marker = Rx<Set<Marker>>({});
  final hybridView = false.obs;

  final latitude2 = Rx<double>(0.0);
  final longitude2 = Rx<double>(0.0);
  Future<String?> openDialog(LatLng argument, BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Changer votre location'),
        content: const Text(
          'Vous etes au point de changer votre location \n voulez vous continuez? ',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.snackbar(
                duration: const Duration(seconds: 2),
                'Confirmation',
                'Location change avec succes',
              );
              latitude.value = argument.latitude;
              longitude.value = argument.longitude;
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Set<Marker> markers() {
    marker.value.add(
      Marker(
          markerId: const MarkerId("marker 1"),
          position: LatLng(latitude.value!, longitude.value!)),
    );
    return marker.value;
  }
}
