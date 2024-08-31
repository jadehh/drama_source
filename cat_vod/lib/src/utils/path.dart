/*
 * @Author: jadehh
 * @Date: 2024-08-14 15:37:24
 * @LastEditTime: 2024-08-20 19:01:33
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\cat_vod\lib\src\utils\path.dart
 * 
 */

import 'dart:io';
import 'dart:typed_data';
import 'package:cat_vod/src/utils/prefers.dart';
import 'package:cat_vod/src/utils/util.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:path/path.dart' as path;

class Path {
  static final String TAG = Path().runtimeType.toString();

  static String getApplicationDocumentsDirectory() {
    return Prefers.getString("application_documents_directory", defaultValue: "");
  }

  static String getApplicationCacheDirectory() {
    return Prefers.getString("application_cache_directory", defaultValue: "");
  }


  static _mkdir(Directory file, {String? name}) {
    try{
      if (!file.existsSync()) file.createSync();
    }catch (e,stackTrace){
      Log.e( "File Path:${file.absolute.path},${e.toString()}", stackTrace);
    }
    return file;
  }

  static bool exists(String path) {
    return Directory(path.replaceAll("file://", "")).existsSync();
  }

  static Directory root({String? child, String? name}) {
    if (child != null) return _mkdir(
        Directory(path.join((root()).absolute.path, child)), name: name);
    if (name != null) return Directory(path.join((root()).absolute.path, name));
    return Directory((getApplicationDocumentsDirectory()));
  }

  static FileSystemEntity download() {
    return _mkdir(Directory((getApplicationDocumentsDirectory()) + "Downloads"));
  }

  static FileSystemEntity cache({String? name}) {
    if (name != null) return File(path.join((cache()).absolute.path, name));
    return Directory((getApplicationCacheDirectory()));
  }

  static FileSystemEntity thunderCache() {
    FileSystemEntity internal = cache();
    String dir = Prefers.getString("thunder_cache_dir", defaultValue: internal.absolute.path);
    if (dir == internal.absolute.path) return internal;
    Directory _cache = Directory(dir);
    if (!_cache.existsSync()) return internal;
    return _cache;
  }

  static FileSystemEntity files({String? name}) {
    if (name != null) return File(path.join((files()).absolute.path, name));
    return Directory((getApplicationDocumentsDirectory()));
  }

  static String rootPath() {
    return (root()).absolute.path;
  }

  static String downloadPath() {
    return (download()).absolute.path;
  }

  static Directory database() {
    return _mkdir(Directory(path.join((root()).absolute.path, "databases")));
  }

  static Directory tv() {
    return _mkdir(Directory(path.join((root()).absolute.path, "TV")));
  }

  static Directory so() {
    return _mkdir(Directory(path.join((files()).absolute.path, "so")));
  }

  static FileSystemEntity js({String? name}) {
    if (name != null)
      return File(path.join((js()).absolute.path, name));
    return _mkdir(Directory(path.join((cache()).absolute.path, "js")));
  }

  static Directory py() {
    return _mkdir(Directory(path.join((cache()).absolute.path, "py")));
  }

  static Future<FileSystemEntity> jar({String? name}) async {
    if (name != null) return new File(
        path.join((await jar()).absolute.path, await Util.md5(name) + ".jar"));
    return _mkdir(Directory(path.join((cache()).absolute.path, "jar")));
  }

  static Directory doh() {
    return _mkdir(Directory(path.join((cache()).absolute.path, "doh")));
  }

  static Directory wall() {
    return _mkdir(Directory(path.join((cache()).absolute.path, "wall")));
  }

  static Directory exo() {
    return _mkdir(Directory(path.join((cache()).absolute.path, "exo")));
  }

  static Directory epg({String? name}) {
    if (name != null) return Directory(path.join((epg()).absolute.path, name));
    return _mkdir(Directory(path.join((cache()).absolute.path, "epg")));
  }

  static Directory jpa() {
    return _mkdir(Directory(path.join((cache()).absolute.path, "jpa")));
  }

  static Directory m3u8() {
    return _mkdir(Directory(path.join((cache()).absolute.path, "m3u8")));
  }

  static FileSystemEntity thunder({String? name}) {
    if (name != null)
      return _mkdir(new Directory(path.join((thunder()).absolute.path, name)));
    return _mkdir(Directory(path.join((cache()).absolute.path, "thunder")));
  }

  static Future<Directory> restore() async {
    return await _mkdir(
        Directory(path.join((await cache()).absolute.path, "restore")));
  }

  static File local(String path) {
    File file1 = File(path.replaceAll("file:/", ""));
    File file2 = File(path.replaceAll("file:/", rootPath()));
    return file2.existsSync() ? file2 : file1.existsSync() ? file1 : File(path);
  }

  static String read({String? path, File? file}) {
    File? _file;
    if (path != null) _file = local(path);
    if (file != null) _file = file;
    try {
      return _file!.readAsStringSync();
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return "";
    }
  }

  static List<int> readToByte(File file) {
    try {
      return file.readAsBytesSync();
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return [];
    }
  }

  static File write(FileSystemEntity fileSystemEntity, {List<int>? data, Uint8List? uint8List, String? str}) {
    File file = File(fileSystemEntity.absolute.path);
    file.createSync();
    try {
      if (data != null) file.writeAsBytesSync(data);
      if (uint8List != null) file.writeAsBytesSync(uint8List);
      if (str != null) {
        file.writeAsStringSync(str);
      }
      return file;
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return file;
    }
  }

  static File utf8(File file) {
    return write(cache(name: path.basename(file.path)), data: readToByte(file));
  }

  static void move(File inFile, File outFile) {
    copy(inFile: inFile, outFile: outFile);
    clear(file: inFile);
  }

  static copy({File? inFile, String? str, File? outFile}) {
    try {
      if (inFile != null && outFile != null) inFile.copySync(
          outFile.absolute.path);
      if (str != null && outFile != null) write(outFile, str: str);
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
    }
  }

  static List list(File dir) {
    List files = Directory(dir.path).listSync();
    return files;
  }

  static clear({File? file, FileSystemEntity? fileSystemEntity}) {
    try {
      if (file != null) file.deleteSync();
      if (fileSystemEntity != null) {
        fileSystemEntity.deleteSync(recursive: true);
        Directory(fileSystemEntity.absolute.path).createSync();
      }

    }
    catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
    }
  }

// static File create(File file) {
// try {
// if (!file.canWrite()) file.setWritable(true);
// if (!file.exists()) file.createNewFile();
// Shell.exec("chmod 777 " + file);
// return file;
// } catch (Exception e) {
// e.printStackTrace();
// return file;
// }
// }
}
