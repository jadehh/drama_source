/*
 * @Author: jadehh
 * @Date: 2024-08-14 15:37:24
 * @LastEditTime: 2024-08-14 16:54:12
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\catvod\utils\path.dart
 * 
 */

import 'dart:io';
import 'dart:typed_data';
import 'package:dramasource/core/model/f_logger.dart';
import 'package:path_provider/path_provider.dart';

class Path {
  static Future<File> _mkdir(File file) async {
    try {
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
        FLogger.get().d("创建成功");
      } else {
        FLogger.get().d("已存在");
      }
    } catch (e) {
       FLogger.get().d(e);
    }
     return file;
  }

  static Future<File> cache() async{
    Directory fileDir = await getApplicationCacheDirectory();
    return File(fileDir.path);
  }

  static Future<File> jsByName(String name) async {
    File jsDir = await js();
    return File("${jsDir.path}/$name");
  }

  static Future<File> js() async {
    File cacheDir = await cache();
    return _mkdir(File("${cacheDir.path}/js"));
  }

  static Future<String> readByDir(File file) async {
        try {
            return file.readAsString();
        } catch (e) {
            return "";
        }
    }

  static void write(File file, Uint8List bodyBytes) {
        file.writeAsBytes(bodyBytes);
  }
}
