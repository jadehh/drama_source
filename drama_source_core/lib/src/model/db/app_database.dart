/*
 * @Author: jadehh
 * @Date: 2024-08-20 13:45:09
 * @LastEditTime: 2024-08-22 14:59:42
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\model\db\app_database.dart
 * 
 */
import 'dart:io';
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/model/db/dao/config_dao.dart';
import 'package:drama_source_core/src/model/db/dao/keep_dao.dart';
import 'package:drama_source_core/src/model/db/dao/live_dao.dart';
import 'package:drama_source_core/src/model/db/dao/site_dao.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppDatabase {
  late Database database;

  static final String SYMBOL = "@@@";

  static const name = "tv.db";

  static const configTableName = "Config";

  static const siteTableName = "Site";

  static const liveTableName = "live";

  static const keepTableName = "keep";

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
    var databasesPath = Path.database();
    String dbpath = join(databasesPath.path, name);
    // if (File(dbpath).existsSync()){
    //   File(dbpath).deleteSync();
    // }
    // open the database
    database = await openDatabase(dbpath, version: Utils.stringToInt(Utils.packageInfo.version));
    Log.d(dbpath);

    await createConfigTable();
    await createSiteTable();
    await createLiveTable();
    await createKeepTable();
  }

  createConfigTable() async {
    bool isExists = await tableExists(configTableName);
    if (!isExists) {
      database.execute(
          '''CREATE TABLE `$configTableName` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `type` INTEGER NOT NULL, `time` INTEGER NOT NULL, `url` TEXT, `json` TEXT, `name` TEXT, `logo` TEXT, `home` TEXT, `parse` TEXT) ''');
      Log.d("创建$configTableName,表完成");
    }
  }

  createSiteTable() async {
    bool isExists = await tableExists(siteTableName);
    if (!isExists) {
      database.execute('''CREATE TABLE `$siteTableName` (`key` TEXT NOT NULL, `searchable` INTEGER, `changeable` INTEGER, PRIMARY KEY(`key`))''');
      Log.d("创建$siteTableName,表完成");
    }
  }

  createLiveTable() async {
    bool isExists = await tableExists(liveTableName);
    if (!isExists) {
      database.execute('''CREATE TABLE `$liveTableName` (`name` TEXT NOT NULL, `boot` INTEGER NOT NULL, `pass` INTEGER NOT NULL, PRIMARY KEY(`name`))''');
      Log.d("创建$liveTableName,表完成");
    }
  }

  createKeepTable() async {
    bool isExists = await tableExists(keepTableName);
    if (!isExists) {
      database.execute('''CREATE TABLE `${keepTableName}` (`key` TEXT NOT NULL, `siteName` TEXT, `vodName` TEXT, `vodPic` TEXT, `createTime` INTEGER NOT NULL, `type` INTEGER NOT NULL, `cid` INTEGER NOT NULL, PRIMARY KEY(`key`))''');
      Log.d("创建$keepTableName,表完成");
    }
  }

  Future<bool> tableExists(String tableName) async {
    var tables = await database.rawQuery('SELECT * FROM sqlite_master WHERE name="$tableName";');
    Log.d(tables.toString());
    return tables.isNotEmpty;
  }

   ConfigDao getConfigDao(){
    return ConfigDao.get();
  }

   SiteDao getSiteDao(){
    return SiteDao.get();
  }

  LiveDao getLiveDao(){
    return LiveDao.get();
  }

  KeepDao getKeepDao(){
    return KeepDao.get();
  }

}
