import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final _userLocation = const LatLng(45.521563, -122.677433).obs;

  Rx<LatLng> get userLocation => _userLocation;
}
