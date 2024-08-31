/*
 * @Author: jadehh
 * @Date: 2024-08-14 15:11:40
 * @LastEditTime: 2024-08-20 18:59:56
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\cat_vod\lib\src\utils\assert.dart
 * 
 */
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Asset {
  static Future<String> open(String filename) async {
    try {
      final directory = await getApplicationCacheDirectory();
      final filePath = '${directory.path}/$filename';
      final file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> read(String fileName)  {
    try {
      return open(fileName);
    } catch (e) {
      rethrow;
    }
  }
}
