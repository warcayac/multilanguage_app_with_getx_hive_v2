import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


/* ============================================================================================= */

extension on HiveInterface {
  /// Get a name list of existing boxes
  Future<List<String>> getNamesOfBoxes() async {
    final appDir = await getApplicationDocumentsDirectory();
    var files = appDir.listSync();
    var _list = <String>[];

    files.forEach((file) {
      if (file.statSync().type == FileSystemEntityType.file 
        && p.extension(file.path).toLowerCase() == '.hive') {
        _list.add(p.basenameWithoutExtension(file.path));
      }
    });
    // print('Current boxes: $_list');
    return _list;
  }
  /* ---------------------------------------------------------------------------- */
  /// Delete existing boxes from disk
  Future<void> deleteBoxes() async {
    final _boxes = await this.getNamesOfBoxes();
    if (_boxes.isNotEmpty) _boxes.forEach((name) => this.deleteBoxFromDisk(name));
  }
}

/* ============================================================================================= */

const _nodeDefaults = 'defaults';
const _nodeTranslations = 'translations';
const _keyLanguage = 'language';
const _langByDefault = 'en_US';

typedef SSMap = Map<String, String>;


class HiveService {
  static late Box<String> boxDefault;
  static late Box<Map> boxTranslations;
  /* ---------------------------------------------------------------------------- */
  static FutureOr<void> setDefault(String code) async => await boxDefault.put(_keyLanguage, code);
  /* ---------------------------------------------------------------------------- */
  static String get defaultLanguage => boxDefault.get(_keyLanguage)!;
  /* ---------------------------------------------------------------------------- */
  static List<String> get codes => (boxDefault.get(_keyLanguage))!.split('_');
  /* ---------------------------------------------------------------------------- */
  static FutureOr<void> _openBoxes() async {
    // if (!Hive.isBoxOpen(_nodeDefaults))
      boxDefault = await Hive.openBox<String>(_nodeDefaults);
    // if (!Hive.isBoxOpen(_nodeTranslations))
      boxTranslations = await Hive.openBox<Map>(_nodeTranslations);
  }
  /* ---------------------------------------------------------------------------- */
  static FutureOr<void> initConfig({bool cleanHive = false}) async {
    await Hive.initFlutter();
    
    if (cleanHive) {
      await _setDefaultHiveStructure();
    } else {
      final valid = await isIntegrityOfBoxesOK();
      if (!valid) {
        await _setDefaultHiveStructure();
      }
    }
  }
  /* ---------------------------------------------------------------------------- */
  static FutureOr<void> _setDefaultHiveStructure() async {
    await Hive.close();    
    await Hive.deleteBoxes();
    await _openBoxes();
    boxDefault.put(_keyLanguage, 'en_US');
  }
  /* ---------------------------------------------------------------------------- */
  static FutureOr<bool> isIntegrityOfBoxesOK() async {
    var list = await Hive.getNamesOfBoxes();
    var flag = list.isNotEmpty && list.contains(_nodeDefaults) && list.contains(_nodeTranslations);
    
    if (flag) {
      await _openBoxes();
      
      try {
        var _lang = boxDefault.get(_keyLanguage, defaultValue: _langByDefault)!;
        if (_lang != _langByDefault) {
          var _data = boxTranslations.get(_lang);
          flag = _data != null;
        }
      } catch(e) {
        print('ERROR: $e');
        await Hive.close();
        flag = false;
      } finally {
        return flag;
      }
    }
    return false;
  }
  /* ---------------------------------------------------------------------------- */
  static void loadTranslations() {
    if (boxTranslations.isNotEmpty) {
      Get.appendTranslations(boxTranslations.toMap().map((key, value) {
        return MapEntry(key as String, value.cast<String, String>());
      }));
    }
  }
}