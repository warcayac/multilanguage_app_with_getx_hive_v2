import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/language_repository.dart';


class WLanguageOption extends StatelessWidget {
  final String country, label;
  final Language language;
  WLanguageOption({Key? key, required this.country, required this.label, required this.language}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
   Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    
    return (states.any(interactiveStates.contains)) 
      ? Colors.blue 
      : states.contains(MaterialState.disabled) 
        ? Colors.blueGrey.shade100
        : Colors.red;
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
                language.applyTranslation(
                  onRequest: () => _buildSnackBar(
                    context: context,
                    message: 'Loading language...', 
                    icon: Icons.cloud_download_outlined, 
                    background: Colors.blueAccent,
                  ),
                );
              }, 
              style: TextButton.styleFrom(alignment: Alignment.centerLeft),
              icon: Flag.fromString(country, height: 20, width: 20), 
              label: Text(label, style: TextStyle(fontSize: 13, color: Colors.black54)),
            ),
          ),
          SizedBox(width: 30),
          Obx(() => Checkbox(
              checkColor: Colors.white,
              value: language.isDefault.value, 
              fillColor: MaterialStateProperty.resolveWith(getColor),
              shape: CircleBorder(),
              onChanged: language.isEnabled.isTrue
                ? (value) => (value! ? language.setDefault() : null)
                : null,
            ),
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
        duration: Duration(milliseconds: 500),
      ));
  }
}
