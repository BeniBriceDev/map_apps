import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomController extends GetxController {
  final _initialLocation = const LatLng(37.422131, -122.084801);

  LatLng get initialLocation => _initialLocation;
  
}
