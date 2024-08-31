/*
 * @File     : live_dao.dart
 * @Author   : jade
 * @Date     : 2024/8/28 上午10:34
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/src/api/bean/live.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_core/src/model/db/dao/base_dao.dart';

class LiveDao extends BaseDao {
  String tableName;

  static final LiveDao _instance = LiveDao._internal(AppDatabase.liveTableName);

  static LiveDao get instance => _instance;

  factory LiveDao() {
    return _instance;
  }

  LiveDao._internal(this.tableName) : super(tableName);

  static LiveDao get() {
    return _instance;
  }

  Future<Live?> find(String name) async {
    List<Map<String, Object?>> maps = await AppDatabase.get().database.rawQuery("SELECT * FROM Live WHERE name = ?", [name]);
    if (maps.isNotEmpty)
      return Live.fromJson(maps.first);
    else
      return null;
  }
}
