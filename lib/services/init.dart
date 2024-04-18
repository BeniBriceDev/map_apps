import 'package:get/get.dart';
import 'package:google_maps/services/fecth_data.dart';


class InitData {
  void initServices() async {
    await Get.putAsync(() => DbService().init());
  }
}
