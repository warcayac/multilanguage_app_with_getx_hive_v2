import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/local_storage.dart';


class RosettaStone extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': {
        'title': 'Berserk',
        'summary': '''
Berserk (Japanese: ベルセルク, Hepburn: Beruseruku) is a Japanese manga series written and illustrated by Kentaro Miura. Set in a medieval Europe-inspired dark fantasy world, the story centers on the characters of Guts, a lone mercenary, and Griffith, the leader of a mercenary band called the "Band of the Hawk". Miura premiered a prototype of Berserk in 1988. The series began the following year in the Hakusensha's now-defunct magazine Monthly Animal House, which was replaced in 1992 by the semimonthly magazine Young Animal, where Berserk continues to be published intermittently. Miura died of aortic dissection in May 2021, leaving it unclear whether the manga will continue to be serialized.
''',
      },
    };
  }

  static Locale locale() {
    var codes = HiveService.codes;
    HiveService.loadTranslations();
    return Locale(codes[0], codes.length > 1 ? codes[1] : null);
  }
}