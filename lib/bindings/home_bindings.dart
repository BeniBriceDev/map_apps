import 'package:get/get.dart';
import 'package:google_maps/controller/custom_controller.dart';
import 'package:google_maps/controller/gps_controller.dart';
import 'package:google_maps/controller/home_controller.dart';
import 'package:google_maps/controller/map_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<GpsController>(() => GpsController());
    Get.lazyPut<CustomController>(() => CustomController());
  }
}
