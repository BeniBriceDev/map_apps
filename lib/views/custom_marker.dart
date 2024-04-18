// import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps/camera/google_util.dart';
import 'package:google_maps/controller/landing_controller.dart';
import 'package:google_maps/widget/map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  final landingController = Get.put(LandingContoller());
  bool hybridView = true;
  void changeView() {
    setState(() {
      if (hybridView) {
        hybridView = false;
      } else {
        hybridView = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoogleUtil());
    final mapWidget = MapWidget();
    final cameraPosition = GoogleUtil();

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
                landingController.latitude.value = argument.latitude;
                landingController.longitude.value = argument.longitude;

                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: hybridView
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  landingController.latitude.value!,
                  landingController.longitude.value!,
                ),
                zoom: 14.4746,
              ),

              mapType: MapType.hybrid,
              onMapCreated: (controller) {
                // cameraPosition.ycontroller.complete(controller);
              },
              onTap: ((argument) {
                openDialog(argument, context);
              }),

              // adding marker
              markers: {
                Marker(
                  markerId: const MarkerId('marchantLoc'),
                  draggable: true,
                  onDrag: (value) {},
                  position: LatLng(
                    landingController.latitude.value!,
                    landingController.longitude.value!,
                  ),
                  infoWindow: const InfoWindow(
                    title: 'Marchant Location',
                    snippet: "Marchant zone",
                  ),
                ),
              },
            )
          : GoogleMap(
              initialCameraPosition: cameraPosition.kGooglePlex,
              onTap: (argument) {
                openDialog(argument, context);
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
                    landingController.latitude.value!,
                    landingController.longitude.value!,
                  ),
                  infoWindow: const InfoWindow(
                    title: 'Marchant Location',
                    snippet: "Marchant zone",
                  ),
                ),
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  changeView();
                },
                icon: const Icon(
                  Icons.remove_red_eye,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

// BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  // final cameraPosition = GoogleUtil();
  // final mapWidget = MapWidget();
  // bool hybridView = false;
  // void changeView() {
  //   setState(() {
  //     if (hybridView) {
  //       hybridView = false;
  //     } else {
  //       hybridView = true;
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   addCustomIcon();
  //   super.initState();
  // }

  // void addCustomIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           const ImageConfiguration(size: Size.zero), "assets/mar3.png")
  //       .then((value) {
  //     setState(() {
  //       markerIcon = value;
  //     });
  //   });
  // }