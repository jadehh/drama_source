/*
 * @Author: jadehh
 * @Date: 2024-08-21 09:25:17
 * @LastEditTime: 2024-08-21 09:29:56
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\cat_vod\lib\src\utils\json.dart
 * 
 */

import 'dart:convert';

import 'package:drama_source_log/drama_source_log.dart';

class Json {
  static Map<String, dynamic> parse(String json) {
    try{
      return jsonDecode(json);
    }
    catch(e){
      return {};
    }
  }

  static bool valid(String text) {
    try {
      jsonDecode(text);
      return true;
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return false;
    }
  }

  static bool invalid(String text) {
    return !valid(text);
  }

  static String safeString(Map<String, dynamic> obj, String key) {
    if (obj.containsKey(key)) {
      if (obj[key] is String) {
        return obj[key];
      }
    }
    return "";
  }

  static List<String> safeListString(Map<String, dynamic> obj, String key) {
    List<String> result = [];
    if (!obj.containsKey(key)) return result;
    if (obj[key] is Map<String, String>)
      result.add(safeString(obj, key));
    else
      for (var opt in obj[key]) result.add(jsonEncode(opt));
    return result;
  }

  static List<Map<String, dynamic>> safeListElement(Map<String, dynamic> obj, String key) {
    List<Map<String, dynamic>> result = [];
    if (!obj.containsKey(key)) return result;
    if (obj[key] is Map<String, dynamic>)
      result.add(obj[key]);
    else
      for (var opt in obj[key]) result.add(opt);
    return result;
  }

  static Map<String, String> toMap({String? str, Map<String, dynamic>? json}) {
    if (str != null) return toMap(json: parse(str));
    if (json != null) {
       {
        Map<String, String> map = {};
        for (var key in json.keys) map[key] = safeString(json, key);
        return map;
      }
    }
    return {};
  }
}
