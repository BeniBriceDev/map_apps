import 'package:get/get.dart';
import 'package:google_maps/bindings/home_bindings.dart';
import 'package:google_maps/pages/name.dart';
import 'package:google_maps/views/custom_marker.dart';
import 'package:google_maps/views/gps_apps.dart';
import 'package:google_maps/views/landing_page.dart';
import 'package:google_maps/views/map_demo.dart';

class AllRouteName {
  static List<GetPage> allPage = [
    GetPage(
      name: AllPageName.home,
      page: () => const MapSample(),
      binding: HomeBindings(),
    ),
    // GetPage(
    //   name: AllPageName.mapview,
    //   page: () {},
    //   binding: HomeBindings(),
    // ),
    GetPage(
      name: AllPageName.gpsPage,
      page: () => const GpsApp(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AllPageName.customVMarker,
      page: () => const CustomMarker(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AllPageName.landingPage,
      page: () => const Landingpage(),
    ),
  ];
}
