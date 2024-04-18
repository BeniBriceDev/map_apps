import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GpsController extends GetxController {
  final _controller = Completer<GoogleMapController>().obs;
  final _sourceDestination = const LatLng(37.33500926, -122.03272188).obs;
  final _destination = const LatLng(37.33429383, -122.06600055).obs;
  Completer<GoogleMapController> get controller => _controller.value;
  LatLng get sourceDestination => _sourceDestination.value;
  LatLng get destination => _destination.value;
  
}
