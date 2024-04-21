import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/landing_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleUtil extends GetxController {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final landingController = Get.put(LandingContoller());
  var hybridView = false.obs;

  LatLng latLng = LatLng(34, 45);
  Position? position;

  void hybrid() {
    print("hello");
  }

  void normalView() {
    hybridView.value = !hybridView.value;
  }

  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      37.4219983,
      -122.084,
    ),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  Future<void> goToTheLake(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  CameraPosition get kGooglePlex => _kGooglePlex;
  CameraPosition get kLake => _kLake;
  Completer<GoogleMapController> get ycontroller => _controller;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/mar.png")
        .then(
      (value) => markerIcon = value,
    );
  }

  @override
  void onInit() {
    addCustomIcon();

    super.onInit();
    update();

    print('Le Bitmap Image est ===>> ========>');
  }
}
