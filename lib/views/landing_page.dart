import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/google_util.dart';
import 'package:google_maps/controller/landing_controller.dart';
import 'package:google_maps/data/app_data.dart';
import 'package:google_maps/pages/name.dart';
import 'package:google_maps/widget/alert_dialog.dart';
import 'package:google_maps/widget/bottom_sheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  String? _currentAddress;
  Position? _currentPosition;
  final landingController = Get.put(LandingContoller());
  final allData = AppData();
  final controller = Get.put(GoogleUtil());
  final dialogWidget = Get.put(ShowDialog());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
    _getCurrentPosition();

    print(
        "c'est la premire fois ${landingController.isFirstRun} latitude de l'application ${allData.latitude} longitude de l'application est ${allData.longitude}");
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (landingController.isFirstRun.value) {
                    landingController.latitude.value =
                        _currentPosition?.latitude;
                    landingController.longitude.value =
                        _currentPosition?.longitude;
                  }

                  landingController.isFirstRun.value = false;

                  dialogWidget.openDialog(context);
                },
                child: const Text("Changer votre location"),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Obx(
                () => landingController.isFirstRun.value
                    ? Text("Votre longitude est ${_currentPosition?.longitude}")
                    : Text(
                        "Votre longitude est ${landingController.longitude}"),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Obx(
                () => landingController.isFirstRun.value
                    ? Text("Votre latitude est ${_currentPosition?.latitude}")
                    : Text("Votre latitude est ${landingController.latitude}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
