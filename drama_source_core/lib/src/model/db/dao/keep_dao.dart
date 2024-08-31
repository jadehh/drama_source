/*
 * @File     : keep_dao.dart
 * @Author   : jade
 * @Date     : 2024/8/28 上午11:28
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/src/api/bean/keep.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_core/src/model/db/dao/base_dao.dart';

class KeepDao extends BaseDao {
  String tableName;

  static final KeepDao _instance = KeepDao._internal(AppDatabase.keepTableName);

  static KeepDao get instance => _instance;

  factory KeepDao() {
    return _instance;
  }

  KeepDao._internal(this.tableName) : super(tableName);

  static KeepDao get() {
    return _instance;
  }

  Future<Keep?> find(String key, {int? cid}) async {
    List<Map<String, Object?>> maps;
    if (cid != null) {
      maps = await AppDatabase.get().database.rawQuery("SELECT * FROM Keep WHERE type = 0 AND cid = ? AND `key` = ?", [cid, key]);
    } else {
      maps = await AppDatabase.get().database.rawQuery("SELECT * FROM Keep WHERE type = 0 AND `key` = ?", [key]);
    }
    if (maps.isNotEmpty)
      return Keep.fromJson(maps.first);
    else
      return null;
  }

  Future<List<Keep>?> getVod() async {
    List<Map<String, Object?>> maps;
    maps = await AppDatabase.get().database.rawQuery("SELECT * FROM Keep WHERE type = 0 ORDER BY createTime DESC");
    if (maps.isNotEmpty) {
      List<Keep> results = [];
      for (var map in maps) {
        results.add(Keep.fromJson(map));
      }
      return results;
    } else
      return null;
  }

  Future<List<Keep>?> getLive() async {
    List<Map<String, Object?>> maps;
    maps = await AppDatabase.get().database.rawQuery("SELECT * FROM Keep WHERE type = 1 ORDER BY createTime DESC");
    if (maps.isNotEmpty) {
      List<Keep> results = [];
      for (var map in maps) {
        results.add(Keep.fromJson(map));
      }
      return results;
    } else
      return null;
  }

  Future delete({int? cid, String? key}) async {
    if (cid == null && key == null)
      await AppDatabase.get().database.rawDelete("DELETE FROM Keep WHERE type = 0");
    if (cid != null && key == null)
      await AppDatabase.get().database.rawDelete("DELETE FROM Keep WHERE type = 0 AND cid = ?", [cid]);
    if (cid == null && key != null)
      await AppDatabase.get().database.rawDelete("DELETE FROM Keep WHERE type = 1 AND `key` = ?", [key]);
    if (cid != null && key != null)
      await AppDatabase.get().database.rawDelete("DELETE FROM Keep WHERE type = 0 AND cid = ? AND `key` = ?", [cid, key]);
  }
}
