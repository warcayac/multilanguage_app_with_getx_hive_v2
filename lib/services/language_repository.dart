import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wnetworking/wnetworking.dart';

import 'local_storage.dart';


class _LanguageRepository {
  static const _base = 'https://gist.githubusercontent.com/warcayac';
  static const chinese =
      '$_base/0950b85ad66b1ab24e64e75a4332af55/raw/0a9490199b01a44c98cbda59fa938ae40c1f6ae2/chinese2.json';
  static const korean =
      '$_base/9ea4a71e4ca5b0e6421b7894da553e2b/raw/eda2b6b11afce0f2dc84431a113b78c28044ec64/korean2.json';
  static const spanish =
      '$_base/588418295d7f611b466b2ac26c8a9e58/raw/37facce683b0672dd38ba8f453c3dbee721cafcf/spanish2.json';
}

/* ============================================================================================= */

typedef SSSMap = Map<String, Map<String, String>>;

abstract class Language extends GetxController {
  final String languageCode;
  final String? countryCode;
  var isDefault = false.obs;
  var isEnabled = false.obs;
  /* ---------------------------------------------------------------------------- */
  static Language? chosen;
  /* ---------------------------------------------------------------------------- */
  Language(this.languageCode, [this.countryCode]) {
    isEnabled.value = Get.translations.keys.contains(code);
    isDefault.value = HiveService.defaultLanguage == code;
    if (isDefault.isTrue) chosen = this;
  }
  /* ---------------------------------------------------------------------------- */
  Future<SSSMap?> _getTranslation(String url) {
    return HttpReqService.getJson<JMap>(url).then((response) {
      if (response != null) {
        var result = response.map((key, value) {
          return MapEntry(key, (value as JMap).cast<String, String>());
        });
        return result;
      }
      return null;
    });
  }
  /* ---------------------------------------------------------------------------- */
  Locale get locale => Locale(languageCode, countryCode);
  String get code => '$languageCode${countryCode != null ? '_$countryCode' : ''}';
  /* ---------------------------------------------------------------------------- */
  FutureOr<void> applyTranslation({required VoidCallback onRequest}) async {
    if (isEnabled.isFalse) {
      late SSSMap? trans; 
      
      await Future.wait([
        Future.delayed(Duration(milliseconds: 10), onRequest),
        getTranslation().then((response) => trans = response),
      ]);

      if (trans != null) {
        Get.appendTranslations(trans!);
        trans!.forEach((key, value) async => await HiveService.boxTranslations.put(key, value));
        isEnabled.value = true;
      }
    }
    Get.updateLocale(locale);
  }
  /* ---------------------------------------------------------------------------- */
  void setDefault() async {
    if (!identical(chosen, this)) {
      await HiveService.setDefault(code);
      chosen!.isDefault.value = false;
      isDefault.value = true;
      chosen = this;
    }
  }
  /* ---------------------------------------------------------------------------- */
  Future<SSSMap?> getTranslation();
}

/* ============================================================================================= */

class EnglishLang extends Language {
  EnglishLang() : super('en', 'US');

  @override
  Future<SSSMap?> getTranslation() => Future.value(null);
}

class ChineseLang extends Language {
  ChineseLang() : super('zh', 'CN');

  @override
  Future<SSSMap?> getTranslation() => _getTranslation(_LanguageRepository.chinese);
}

class KoreanLang extends Language {
  KoreanLang() : super('ko');

  @override
  Future<SSSMap?> getTranslation() => _getTranslation(_LanguageRepository.korean);
}

class SpanishLang extends Language {
  SpanishLang() : super('es', 'PE');

  @override
  Future<SSSMap?> getTranslation() => _getTranslation(_LanguageRepository.spanish);
}
