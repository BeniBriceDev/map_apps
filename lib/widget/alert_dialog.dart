import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/landing_controller.dart';
import 'package:google_maps/views/custom_marker.dart';
import 'package:google_maps/widget/map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MessageExampleClass extends StatelessWidget {
  const MessageExampleClass({
    super.key,
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    final landingController = Get.put(LandingContoller());
    void saveUserCord() {
      landingController.latitude.value = latitude;
      landingController.longitude.value = longitude;
    }

    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => saveUserCord(),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

class ShowDialog extends GetxController {
  Future<String?> openDialog(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final mapWidget = Get.put(MapWidget());
    final hybridView = Rx<bool>(false);
    void changeView() {
      if (hybridView.value) {
        hybridView.value = false;
      } else {
        hybridView.value = true;
      }
    }

    BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
    const customMarker = CustomMarker();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          titlePadding: EdgeInsets.all(3),
          contentPadding: EdgeInsets.all(8),

          content: customMarker,
          // Scaffold(

          //   body: Stack(
          //     children: [
          //       IconButton(
          //         onPressed: () => changeView(),
          //         icon: const Icon(
          //           Icons.remove_red_eye,
          //           color: Colors.black,
          //         ),
          //       ),
          //       hybridView.value
          //           ? mapWidget.hybrid(markerIcon, context)
          //           : mapWidget.normalView(markerIcon),
          //     ],
          //   ),
          //   floatingActionButton: FloatingActionButton(
          //     onPressed: () {},
          //     child: IconButton(
          //       onPressed: () => changeView(),
          //       icon: const Icon(
          //         Icons.remove_red_eye,
          //       ),
          //     ),
          //   ),
          //   floatingActionButtonLocation:
          //       FloatingActionButtonLocation.startFloat,
          // ),
        );
      },
    );
  }
}
