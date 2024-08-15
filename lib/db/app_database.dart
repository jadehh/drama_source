/*
 * @Author: jadehh
 * @Date: 2024-08-15 10:30:52
 * @LastEditTime: 2024-08-15 16:10:37
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\db\app_database.dart
 * 
 */
import 'dart:io';
import 'package:dramasource/core/model/f_logger.dart';
import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/core/utils/util.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppDatabase {
  late Database database;

  static const name = "tv.db";

  static const configTableName = "Config";

  static final AppDatabase _instance = AppDatabase._internal();

  static AppDatabase get instance => _instance;

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  static AppDatabase get() {
    return _instance;
  }

  Future<void> init() async {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }
    // Get a location using getDatabasesPath
    var databasesPath = await getApplicationCacheDirectory();
    String dbpath = join(databasesPath.path, name);
    // open the database
    database = await openDatabase(dbpath,
        version: Util.stringToInt(Setting.getVersion()));
    FLogger.get().d(dbpath);

    await createConfigTable();
  }

  createConfigTable() async {
    bool isExists = await tableExists(configTableName);
    if (!isExists) {
      database.execute(
          '''CREATE TABLE `$configTableName` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `type` INTEGER NOT NULL, `time` INTEGER NOT NULL, `url` TEXT, `json` TEXT, `name` TEXT, `logo` TEXT, `home` TEXT, `parse` TEXT) ''');
      FLogger.get().d("创建$configTableName,表完成");
    }
  }

  Future<bool> tableExists(String tableName) async {
    var tables = await database.rawQuery('SELECT * FROM sqlite_master WHERE name="$tableName";');
    FLogger.get().d(tables);
    return tables.isNotEmpty;
  }
}
