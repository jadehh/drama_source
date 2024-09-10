/*
 * @File     : console.dart
 * @Author   : jade
 * @Date     : 2024/9/6 9:42
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_log/drama_source_log.dart';
import 'package:flutter_qjs/flutter_qjs.dart';

class Console{
  static const String name = "console";
  static IsolateFunction _log =  IsolateFunction(( text) {
    Log.JSInfo(text);
  });
  static IsolateFunction _debug =  IsolateFunction((String text) {
    Log.JSDebug(text);
  });
  static List setConsole() {
    return [
      name,{"log": _log,"debug":_debug}
    ];
  }
}