import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'widgets/drawer.dart';


class HomePage extends StatelessWidget {
  /* ---------------------------------------------------------------------------- */
  const HomePage({Key? key}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: WDrawer(),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: _buildDropCapText(),
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Widget _buildCover({double? height, double? width}) {
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      // padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
      child: Image.asset(
        'assets/images/221469_489668.jpg', 
        fit: BoxFit.contain,
        alignment: Alignment.topRight,
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  DropCapText _buildDropCapText() {
    return DropCapText(
      'summary'.tr,
      dropCapPosition: DropCapPosition.end,
      dropCap: DropCap(
        child: _buildCover(), 
        width: 210, 
        height: 220,
      ),
      style: GoogleFonts.specialElite(
        height: 1.5,
        wordSpacing: 2.5,
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  AppBar _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(), 
            icon: Icon(Icons.menu),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text('title'.tr),
      centerTitle: true,
    );
  }
}
