import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/language_repository.dart';

import 'language_option.dart';


class WDrawer extends StatelessWidget {
  const WDrawer({
    Key? key,
  }) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 8, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              Divider(thickness: 2),
              SizedBox(height: 10),
              Text('Choose your favorite language.', style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              _buildDefaultText(),
              WLanguageOption(country: 'us', label: 'English', language: EnglishLang()),
              WLanguageOption(country: 'cn', label: '中文', language: ChineseLang()),
              WLanguageOption(country: 'kr', label: '한국어', language: KoreanLang()),
              WLanguageOption(country: 'es', label: 'Español', language: SpanishLang()),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Row _buildDefaultText() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Default', 
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ),
        SizedBox(width: 7),
      ],
    );
  }
  /* ---------------------------------------------------------------------------- */
  Text _buildTitle() {
    return Text(
      'Languages', 
      style: GoogleFonts.dancingScript(
        textStyle: TextStyle(fontSize: 35, color: Colors.blueGrey[700]),
        shadows: [
          Shadow(offset: Offset(1.5, 1.5), color: Colors.grey.shade400),
        ]
      ),
      textAlign: TextAlign.left,
    );
  }
}