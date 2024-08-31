/*
 * @File     : config_dao.dart
 * @Author   : jade
 * @Date     : 2024/08/21 08:15:36
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_core/src/model/db/dao/base_dao.dart';

class ConfigDao extends BaseDao {
  String tableName;

  static final ConfigDao _instance = ConfigDao._internal(AppDatabase.configTableName);

  static ConfigDao get instance => _instance;

  factory ConfigDao() {
    return _instance;
  }

  ConfigDao._internal(this.tableName) : super(tableName);

  static ConfigDao get() {
    return _instance;
  }

  Future<List<Config>?> findByType(int type) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.rawQuery('SELECT * FROM ${tableName} WHERE type = ? ORDER BY time DESC', [type]);
    if (maps.isNotEmpty) return Config.arrayFrom(maps);
    else return null;
  }

  Future<List<Config>?> findUrlByType(int type) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.rawQuery('SELECT id, name, url, type, time FROM ${tableName} WHERE type = ? ORDER BY time DESC', [type]);
    if (maps.isNotEmpty) return Config.arrayFrom(maps);
    else return null;
  }

  Future<Config?> findById(int id) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.rawQuery('SELECT * FROM ${tableName} WHERE id = ? ', [id]);
    if (maps.isNotEmpty) return Config.fromJson(maps.first);
    else return null;
  }

  Future<Config?> findOne(int type) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.rawQuery('SELECT * FROM ${tableName} WHERE type = ? ORDER BY time DESC LIMIT 1 ', [type]);
    if (maps.isNotEmpty) return Config.fromJson(maps.first);
    else return null;
  }

  Future<Config?> find(String url, int type) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.rawQuery('SELECT * FROM ${tableName} WHERE url = ? AND type = ?', [url, type]);
    if (maps.isNotEmpty) return Config.fromJson(maps.first);
    else return null;
  }

  Future <void> delete({String? url, int? type}) async {
    if (url != null && type != null) await AppDatabase.get().database.rawDelete("DELETE FROM ${tableName} WHERE url = ? AND type = ?", [url, type]);
    if (url != null) await AppDatabase.get().database.rawDelete("DELETE FROM ${tableName} WHERE url = ?", [url]);
    if (type != null) await AppDatabase.get().database.rawDelete("DELETE FROM ${tableName} WHERE type = ?", [type]);
  }
}
