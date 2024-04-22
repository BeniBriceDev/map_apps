import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/landing_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker>
    with TickerProviderStateMixin {
  final landingController = Get.put(LandingContoller());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool hybridView = true;
  bool showDialoge = false;

  void changeView() {
    setState(() {
      if (hybridView) {
        hybridView = false;
      } else {
        hybridView = true;
      }
    });
  }

  void showDialogText() {
    if (showDialoge) {
      showDialoge = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 1.3;

    LatLng? arguments;
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
              child: const Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: () {
                Get.snackbar(
                  backgroundColor: const Color.fromARGB(
                    255,
                    46,
                    44,
                    44,
                  ),
                  colorText: Colors.white,
                  duration: const Duration(
                    seconds: 2,
                  ),
                  'Confirmation',
                  'Location change avec succes',
                );
                landingController.latitude.value = argument.latitude;
                landingController.longitude.value = argument.longitude;

                setState(() {});
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    onTapUpdate(LatLng argument) {
      landingController.stateLatitude.value = argument.latitude;
      landingController.stateLongitude.value = argument.longitude;

      setState(() {});
      setState(() {
        arguments = argument;
        showDialoge = true;
      });
      setState(() {});
      print(arguments!.latitude);
    }

    CameraPosition cameraPosition() {
      return CameraPosition(
        target: LatLng(
          landingController.stateLatitude.value!,
          landingController.stateLongitude.value!,
        ),
        zoom: 14.4746,
      );
    }

    Future<void> changeLocation() async {
      final GoogleMapController controller = await _controller.future;
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition()));
    }

    List<Widget> bottomNav() {
      return [
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              IconButton(
                onPressed: () => changeView(),
                icon: const Icon(Icons.remove_red_eye),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    landingController.stateLatitude.value =
                        landingController.latitude.value;
                    landingController.stateLongitude.value =
                        landingController.longitude.value;
                  });
                  changeLocation();
                },
                icon: const Icon(Icons.location_on),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    showDialoge = false;
                  });
                },
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    backgroundColor: const Color.fromARGB(
                      255,
                      46,
                      44,
                      44,
                    ),
                    colorText: Colors.white,
                    duration: const Duration(
                      seconds: 2,
                    ),
                    'Confirmation',
                    'Location change avec succes',
                  );
                  landingController.latitude.value =
                      landingController.stateLatitude.value;
                  landingController.longitude.value =
                      landingController.stateLongitude.value;

                  Navigator.pop(context);
                },
                child: const Text('Confirmer'),
              ),
            ],
          ),
        )
      ];
    }

    return Scaffold(
      body: hybridView
          ? Stack(
              children: [
                bottomNav()[0],
                showDialoge ? bottomNav()[1] : Container(),
                SizedBox(
                  height: height,
                  width: 300,
                  child: GoogleMap(
                    initialCameraPosition: cameraPosition(),
                    mapType: MapType.hybrid,
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    onTap: ((argument) => onTapUpdate(argument)),

                    // adding marker
                    markers: {
                      Marker(
                        markerId: const MarkerId('marchantLoc'),
                        draggable: true,
                        onDrag: (value) {},
                        position: LatLng(
                          landingController.stateLatitude.value!,
                          landingController.stateLongitude.value!,
                        ),
                        infoWindow: const InfoWindow(
                          title: 'Marchant Location',
                          snippet: "Marchant zone",
                        ),
                      ),
                    },
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                bottomNav()[0],
                showDialoge ? bottomNav()[1] : Container(),
                SizedBox(
                  height: height,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        landingController.stateLatitude.value!,
                        landingController.stateLongitude.value!,
                      ),
                      zoom: 14.4746,
                    ),
                    onTap: (argument) => onTapUpdate(argument),

                    onMapCreated: (controller) {
                      try {
                        // cameraPosition.ycontroller.complete(controller);
                      } on StateError {}
                    },
                    // adding marker
                    markers: {
                      Marker(
                        markerId: const MarkerId('marchantLoc'),
                        draggable: true,
                        position: LatLng(
                          landingController.stateLatitude.value!,
                          landingController.stateLongitude.value!,
                        ),
                        infoWindow: const InfoWindow(
                          title: 'Marchant Location',
                          snippet: "Marchant zone",
                        ),
                      ),
                    },
                  ),
                ),
              ],
            ),
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