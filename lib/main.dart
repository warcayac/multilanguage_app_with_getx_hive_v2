import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:responsive_builder/responsive_builder.dart';

import 'config/app.dart';
import 'config/translations/rosetta_stone.dart';
import 'pages/home/home_page.dart';
import 'services/local_storage.dart';


void main() async {
  // ResponsiveSizingConfig.instance.setCustomBreakpoints(
  //   ScreenBreakpoints(desktop: 1100, tablet: 850, watch: 200),
  // );
  await HiveService.initConfig(cleanHive: false);
  runApp(MyApp());
  // runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));
}

/* ============================================================================================= */

class MyApp extends StatelessWidget {
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return _buildMaterialApp(context);
  }
  /* ---------------------------------------------------------------------------- */
  Widget _buildMaterialApp(BuildContext context) {
    return GetMaterialApp(
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: WApp.material.googleTextTheme(context),
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      translations: RosettaStone(),
      locale: RosettaStone.locale(),
      fallbackLocale: Locale('en', 'US'),
      home: HomePage(),
    );
  }
}
