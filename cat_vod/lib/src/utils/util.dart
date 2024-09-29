/*
 * @Author: jadehh
 * @Date: 2024-08-21 09:02:29
 * @LastEditTime: 2024-08-21 09:16:03
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\cat_vod\lib\src\utils\util.dart
 * 
 */
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drama_source_log/drama_source_log.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:cat_vod/src/utils/path.dart';

class Util {
  static const int partSize = 1024 * 1024 * 3; //默认3m每块

  static final String CHROME =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36";

  static String base64ToStr({String? s, Uint8List? utf8List}) {
    if (s != null) return base64ToStr(utf8List: utf8.encode(s));
    if (utf8List != null) return base64.encode(utf8List);
    return "";
  }

  static Future<String> getIp() async {
    try {
      String ip = "";
      for (var interface in await NetworkInterface.list()) {
        if (interface.name != "Clash") {
          for (var addr in interface.addresses) {
            // Log.d('${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
            ip = addr.address;
            if (ip.contains("192")) {
              return ip;
            }
          }
        }
      }
      return ip;
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return "";
    }
  }

  static bool equals(String name, String md5Str) {
    return md5(file: Path.jar(name: name)) == md5Str.toLowerCase();
  }

  static String md5({String? src, FileSystemEntity? file}) {
    var md5 = crypto.md5;
    if (src != null) {
      try {
        if (TextUtils.isEmpty(src)) return "";
        var sb = hex.encode(md5.convert(utf8.encode(src)).bytes);
        while (sb.length < 32) "0" + sb;
        return sb.toString().toLowerCase();
      } catch (e) {
        return "";
      }
    }
    if (file != null) {
      var md5 = crypto.md5;
      if (file.existsSync()) {
        return md5
            .convert(File(file.absolute.path).readAsBytesSync())
            .toString(); // 283M文件用时14148毫秒
      } else {
        return "";
      }
    }
    return "";
  }

  static getDigit(String? text) {
    try {
      if (text!.startsWith("上") || text.startsWith("下")) return -1;
      return int.parse(text
          .replaceAll("(?i)(mp4|H264|H265|720p|1080p|2160p|4K)", "")
          .replaceAll("\\D+", ""));
    } catch (e) {
      return -1;
    }
  }

  static bool containOrMatch(String text, String regex) {
    try {
      return text.contains(regex) || RegExp(regex).hasMatch(text);
    } catch (e) {
      return false;
    }
  }
}
