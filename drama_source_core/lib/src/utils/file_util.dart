/*
 * @Author: jadehh
 * @Date: 2024-08-19 13:06:38
 * @LastEditTime: 2024-08-19 13:06:38
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\utils\file_util.dart
 * 
 */
import 'dart:io';
import 'dart:math';
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/impl/call_back.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:path/path.dart' as path;

class FileUtil {
  static String getWall(int index) {
    if (index == 0){
      return path.joinAll([Path.wall().absolute.path,"wallpaper_$index.webp"]);
    }else return  "assets/images/wall/wallpaper_$index.webp";
  }

  static  getCacheSize(Callback callback)  {
    String result = byteCountToDisplaySize(getFolderSize(( Path.cache()) as Directory?));
    callback.success(result);
  }

  static String byteCountToDisplaySize(int size) {
    if (size <= 0) return "0 KB";
    List<String> units = ["bytes", "KB", "MB", "GB", "TB"];
    int digitGroups = (log(size) / log(1024)).toInt();
    return (size / pow(1024, digitGroups)).toStringAsFixed(2) + " " + units[digitGroups];
  }

  static int getFolderSize(Directory? dir) {
    int size = 0;
    if (dir == null) return 0;
    try {
      if (dir.existsSync()) {
        dir.listSync(recursive: true, followLinks: false).forEach((FileSystemEntity entity) {
          if (entity is File) {
            size += entity.lengthSync();
          }
        });
      }
    } catch (e,stackTrace) {
      Log.e(e.toString(), stackTrace);
    }
    return size;
  }

  static void clearCache(Callback callback) {
    Path.clear(fileSystemEntity: Path.cache());
    callback.success();

  }
}
