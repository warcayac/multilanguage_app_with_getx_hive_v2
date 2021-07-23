import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:responsive_builder/responsive_builder.dart';


void main() {
  // ResponsiveSizingConfig.instance.setCustomBreakpoints(
  //   ScreenBreakpoints(desktop: 1100, tablet: 850, watch: 200),
  // );
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
  MaterialApp _buildMaterialApp(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: _getTextTheme(context),
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
  /* ---------------------------------------------------------------------------- */
  TextTheme _getTextTheme(BuildContext context, [int index = 0]) {
    final _textTheme = Theme.of(context).textTheme;
    final _themes = [
      GoogleFonts.interTextTheme, // default
      GoogleFonts.titilliumWebTextTheme,
      GoogleFonts.notoSansTextTheme,
      GoogleFonts.ptSansNarrowTextTheme,
    ];
    return _themes[index](_textTheme);
  }
}
