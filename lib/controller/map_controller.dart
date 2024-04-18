import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../src/locations.dart' as locations;

class MapController extends GetxController {
  late GoogleMapController mapController;
  final markers = RxMap<String, Marker>({});

  final _latLng = const LatLng(45.521563, -122.677433).obs;
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();

    markers.clear();
    for (final office in googleOffices.offices) {
      final marker = Marker(
        markerId: MarkerId(office.name),
        position: LatLng(office.lat, office.lng),
        infoWindow: InfoWindow(
          title: office.name,
          snippet: office.address,
        ),
      );
      markers[office.name] = marker;
    }
  }

  LatLng get latLng => _latLng.value;
  @override
  void onInit() async {
    // await onMapCreated(mapController);
    print('user location ====> $latLng =====>');
  }
}
