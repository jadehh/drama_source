/*
 * @File     : file_manager_system.dart
 * @Author   : jade
 * @Date     : 2024/9/27 13:49
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:file/local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:file/file.dart' hide FileSystem;

class FileManagerSystem extends FileSystem {
  final Future<Directory> _fileDir;
  final String _cacheKey;

  FileManagerSystem(this._cacheKey) : _fileDir = createDirectory(_cacheKey);

  static Future<Directory> createDirectory(String key) async {
    final baseDir = await getApplicationCacheDirectory();
    final path = p.join(baseDir.path, key);
    const fs = LocalFileSystem();
    final directory = fs.directory(path);
    await directory.create(recursive: true);
    return directory;
  }

  @override
  Future<File> createFile(String name) async {
    final directory = await _fileDir;
    if (!(await directory.exists())) {
      await createDirectory(_cacheKey);
    }
    return directory.childFile(name);
  }
}
