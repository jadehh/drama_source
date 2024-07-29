/*
 * @Author: jadehh
 * @Date: 2024-07-17 14:10:23
 * @LastEditTime: 2024-07-19 16:40:25
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\core\model\Prefers.dart
 * 
 */

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// 管理SharedPreferences的键和值。
class Prefers {
  static final Prefers _instance = Prefers._internal();

  static Prefers get instance => _instance;

  factory Prefers() {
    return _instance;
  }
  late SharedPreferences preferences;

  Prefers._internal();

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }


   int getInt(String key) {
    return getIntDefault(key, 0);
  }
  // 使用泛型方法设置值
  void set(String key,  value)  {
    String keyString = key.toString();
    if (value is String) {
      preferences.setString(keyString, value);
    } else if (value is bool) {
      preferences.setBool(keyString, value);
    } else if (value is int) {
      preferences.setInt(keyString, value);
    } else if (value is double) {
      preferences.setDouble(keyString, value);
    } else if (value is List<String>) {
      preferences.setStringList(keyString, value);
    } else {
      throw Exception('Unsupported type');
    }
  }


   String getString(String key) {
    return getStringDefault(key, "");
  }

   String getStringDefault(String key, String defaultValue) {
    return preferences.getString(key) ?? defaultValue;
  }
   int getIntDefault(String key, int defaultValue) {
    return preferences.getInt(key) ?? defaultValue;
  }

}
