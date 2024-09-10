/*
 * @File     : local.dart
 * @Author   : jade
 * @Date     : 2024/9/6 11:25
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:flutter_qjs/flutter_qjs.dart';

class Local {
  static const String name = "local";

  static String _getKey(String rule, String key) {
    return "cache_" + (TextUtils.isEmpty(rule) ? "" : rule + "_") + key;
  }


  static IsolateFunction _set =  IsolateFunction((String rule, String key, String value) async {
      await Prefers.put(_getKey(rule, key), value);
  });

  // static IsolateFunction _get =  IsolateFunction((String rule, String key) {
  //     return Prefers.getString(_getKey(rule, key));
  // });
  //
  static _get(String rule, String key) {
      return Prefers.getString(_getKey(rule, key));
  }

  static List setLocal() {
    return [
      name,
      {
        "set": _set,
        "get": _get,
      }
    ];
  }
}
