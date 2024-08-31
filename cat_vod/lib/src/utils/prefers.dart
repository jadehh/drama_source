/*
 * @File     : prefers.dart
 * @Author   : jade
 * @Date     : 2024/8/26 上午9:48
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'dart:io';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:hive/hive.dart';

class Prefers {
  static late Box settingsBox;

  static const String kHomeSort = "HomeSort";

  static Box _getPrefers() {
    return settingsBox;
  }

  Future init() async {
    settingsBox = await Hive.openBox(
      "LocalStorage",
    );
  }

  static String getString(dynamic key, {String defaultValue = ""}) {
    try {
      String value = settingsBox.get(key, defaultValue: defaultValue) as String;
      // Log.d("Get String Value：$key\r\n$value");
      return value;
    } catch (e) {
      Log.logPrint(e);
      return defaultValue;
    }
  }

  static int getInt(dynamic key, {int defaultValue = 0}) {
    try {
      int value = settingsBox.get(key, defaultValue: defaultValue) as int;
      // Log.d("Get int Value：$key\r\n$value");
      return value;
    } catch (e) {
      Log.logPrint(e);
      return defaultValue;
    }
  }

  static double getFloat(dynamic key, {double defaultValue = 0.0}) {
    try {
      double value = settingsBox.get(key, defaultValue: defaultValue) as double;
      // Log.d("Get double Value：$key\r\n$value");
      return value;
    } catch (e) {
      Log.logPrint(e);
      return defaultValue;
    }
  }

  static bool getBoolean(dynamic key, {bool defaultValue = false}) {
    try {
      bool value = settingsBox.get(key, defaultValue: defaultValue) as bool;
      // Log.d("Get bool Value：$key\r\n$value");
      return value;
    } catch (e) {
      Log.logPrint(e);
      return defaultValue;
    }
  }

  static Directory? getDirectory(dynamic key, {Directory? defaultValue }) {
    try {
      Directory value = settingsBox.get(key, defaultValue: defaultValue) as Directory;
      // Log.d("Get bool Value：$key\r\n$value");
      return value;
    } catch (e) {
      Log.logPrint(e);
      return defaultValue;
    }
  }

  static Future put<T>(dynamic key, T value) async {
    // Log.d("Set LocalStorage：$key\r\n$value");
    return await settingsBox.put(key, value);
  }

  Future remove<T>(String key) async {
    await _getPrefers().delete(key);
  }

  static Future<void> backup(File file) async {
    await Path.write(file, str: _getPrefers().toString());
  }

  static Future<void> restore(File file) async {
    try {
      Map<String, dynamic> map = Json.parse( Path.read(file: file));
      for (var key in map.keys) {
        await Prefers.put(key, _convert(map, key));
      }
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
    }
  }

  static dynamic _convert(Map<String, dynamic> map, String key) {
    if ("danmu_size" == key) {
      return map[key] as double;
    } else {
      return map[key];
    }
  }
}
