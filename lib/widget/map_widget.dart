import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/camera/google_util.dart';
import 'package:google_maps/controller/landing_controller.dart';
import 'package:google_maps/data/app_data.dart';
import 'package:google_maps/pages/name.dart';
import 'package:google_maps/widget/alert_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

class MapWidget extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setLongLat(double latitude, double longitude) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble('latitude', latitude);
    prefs.setDouble('longitude', longitude);

    print(
        'latitude  ${prefs.getDouble('latitude')} latitude ${prefs.getDouble('longitude')} longitude');
  }

  final landingController = Get.put(LandingContoller());

  @override
  void onInit() async {
    super.onInit();
  }

  final cameraPosition = GoogleUtil();
  final allData = AppData();
  saveUserCord(double latitude, double longitude) {
    landingController.latitude.value = latitude;
    landingController.longitude.value = longitude;
  }

  Widget hybrid(BuildContext context) {
    return GetBuilder<LandingContoller>(
      builder: (controller) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              controller.latitude.value!,
              controller.longitude.value!,
            ),
            zoom: 14.4746,
          ),

          mapType: MapType.hybrid,
          onMapCreated: (controller) {
            // cameraPosition.ycontroller.complete(controller);
          },
          onTap: ((argument) {
            landingController.openDialog(argument, context);
          }),

          // adding marker
          markers: {
            Marker(
              markerId: const MarkerId('marchantLoc'),
              draggable: true,
              onDrag: (value) {},
              position: LatLng(
                controller.latitude.value!,
                controller.longitude.value!,
              ),
              infoWindow: const InfoWindow(
                title: 'Marchant Location',
                snippet: "Marchant zone",
              ),
            ),
          },
        );
      },
    );
  }

  Widget normalView(BitmapDescriptor markerIcon, BuildContext context) {
    return GetBuilder<LandingContoller>(
        init: LandingContoller(),
        builder: (controller) {
          return GoogleMap(
            initialCameraPosition: cameraPosition.kGooglePlex,
            onTap: (argument) {
              controller.openDialog(argument, context);
            },

            onMapCreated: (controller) {
              try {
                // cameraPosition.ycontroller.complete(controller);
              } on StateError {
                print('continue');
              }
            },
            // adding marker
            markers: {
              Marker(
                markerId: const MarkerId('marchantLoc'),
                draggable: true,
                position: LatLng(
                  controller.latitude.value!,
                  controller.longitude.value!,
                ),
                infoWindow: const InfoWindow(
                  title: 'Marchant Location',
                  snippet: "Marchant zone",
                ),
              ),
            },
          );
        });
  }
}
