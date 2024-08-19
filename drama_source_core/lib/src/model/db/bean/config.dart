/*
 * @Author: jadehh
 * @Date: 2024-08-15 11:12:46
 * @LastEditTime: 2024-08-15 18:47:00
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\db\bean\config.dart
 * 
 */


import 'package:drama_source_core/src/model/db/app_database.dart';

class Config {
  int id = 0;
  int type = 0;
  int time = 0;
  String? url;
  String? name;
  String? json;
  String? logo;
  String? home;
  String? parse;

  Config();

  static List<String> columns() {
    return [
      "id",
      "type",
      "time",
      "url",
      "name",
      "json",
      "logo",
      "home",
      "parse"
    ];
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "type": type,
      "time": time,
      "url": url,
      "json": json,
      "name": name,
      "logo": logo,
      "home": home,
      "parse": parse
    };
    if (id != 0) {
      map["id"] = id;
    }
    return map;
  }

  Config.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"];
    type = map["type"];
    time = map["time"];
    url = map["url"];
    json = map["json"];
    name = map["name"];
    logo = map["logo"];
    home = map["home"];
    parse = map["parse"];
  }

  static Future<Config> vod() async {
    Config? item = await ConfigDao.get().findOne(0);
    return item ?? create(0);
  }

  static Config create(int type) {
    Config config = Config();
    config.type = type;
    return config;
  }

  static Future<Config> createTypeAndUrl(int type, String url) async {
    Config config = Config();
    config.type = type;
    config.url = url;
    await ConfigDao.get().insert(config);
    return config;
  }

  String getDesc() {
    return name ?? url ?? "";
  }

  Future<Config> findUrlAndType(String url, int type) async {
    Config? item = await ConfigDao.get().findUrlAndType(url, type);
    if (item == null) {
      return await createTypeAndUrl(type, url);
    } else {
      item.type = type;
      return item;
    }
  }
}

class ConfigDao {
  static final ConfigDao _instance = ConfigDao._internal();

  static ConfigDao get instance => _instance;

  factory ConfigDao() {
    return _instance;
  }

  ConfigDao._internal();

  static ConfigDao get() {
    return _instance;
  }

  Future<Config> insert(Config config) async {
    config.id = await AppDatabase.get()
        .database
        .insert(AppDatabase.configTableName, config.toMap());
    return config;
  }

  Future<Config?> findById(int id) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.query(
        AppDatabase.configTableName,
        columns: Config.columns(),
        where: '"id" = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Config.fromMap(maps.first);
    }
    return null;
  }

  Future<Config?> findOne(int type) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.query(
        AppDatabase.configTableName,
        columns: Config.columns(),
        where: '"type" = ?',
        whereArgs: [type],
        orderBy: "time DESC",
        limit: 1);
    if (maps.isNotEmpty) {
      return Config.fromMap(maps.first);
    }
    return null;
  }

  Future<Config?> findUrlAndType(String url, int type) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.query(
        AppDatabase.configTableName,
        columns: Config.columns(),
        where: '"url" = ? AND type = ?',
        whereArgs: [url, type]);
    if (maps.isNotEmpty) {
      return Config.fromMap(maps.first);
    }
    return null;
  }

  Future<int?> update(Config config) async {
    return await AppDatabase.get().database.update(
        AppDatabase.configTableName, config.toMap(),
        where: '"id" = ?', whereArgs: [config.id]);
  }
}
