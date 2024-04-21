import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/pages/name.dart';
import 'package:google_maps/pages/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map Exemple',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AllPageName.landingPage,
      getPages: AllRouteName.allPage,
    );
  }
}
