import 'package:flag/flag.dart';
import 'package:flutter/material.dart';


class WLanguageOption extends StatelessWidget {
  final String countryCode, label;
  final bool selected;
  WLanguageOption({Key? key, required this.countryCode, required this.label, this.selected = false}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
   Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();        
                _buildSnackBar(
                  context: context,
                  message: 'Loading language...', 
                  icon: Icons.cloud_download_outlined, 
                  background: Colors.blueAccent,
                );
              }, 
              style: TextButton.styleFrom(alignment: Alignment.centerLeft),
              icon: Flag.fromString(countryCode, height: 20, width: 20), 
              label: Text(label, style: TextStyle(fontSize: 13, color: Colors.black54)),
            ),
          ),
          SizedBox(width: 30),
          Checkbox(
            checkColor: Colors.white,
            value: selected, 
            fillColor: MaterialStateProperty.resolveWith(getColor),
            shape: CircleBorder(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  void _buildSnackBar({required BuildContext context, required message, required icon, required background}) {
    ScaffoldMessenger
      .of(context)
      .showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(width: 10),
            Text(message, style: TextStyle(fontSize: 16)),
          ],
        ),
        backgroundColor: background,
        duration: Duration(seconds: 2),
      ));
  }
}
