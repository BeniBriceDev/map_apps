import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../src/locations.dart' as locations;

// class FetchData extends GetxService {
//   late GoogleMapController mapController;
//   Map<String, Marker> markers = {};
//   Future<void> onMapCreated() async {
//     final googleOffices = await locations.getGoogleOffices();
//     markers.clear();

//     for (var office in googleOffices.offices) {
//       final marker = Marker(
//         markerId: MarkerId(
//           office.name,
//         ),
//         position: LatLng(office.lat, office.lng),
//         infoWindow: InfoWindow(
//           title: office.name,
//           snippet: office.address,
//         ),
//       );
//       markers[office.name] = marker;
//     }
//     mapController = controller;
//   }
// }

class DbService extends GetxService {
  Future<DbService> init() async {
    print('$runtimeType retarde de 2 sec');
    await 2.delay();
    print('$runtimeType prêts!');
    return this;
  }
}
