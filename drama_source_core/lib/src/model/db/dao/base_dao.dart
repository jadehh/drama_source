/*
 * @File     : base_dao.dart
 * @Author   : jade
 * @Date     : 2024/8/23 上午9:03
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:drama_source_core/src/model/db/app_database.dart';

class BaseDao {
  final String tableName;

  BaseDao(this.tableName);

  Future<int> insert(Map<String, dynamic> item) async {
    if (item.containsKey("id")){
        item.remove("id");
    }
    return  await AppDatabase.get().database.insert(this.tableName, item);
  }

  Future<List<int>> insertList(List<Map<String, dynamic>> itemList) async {
    List<int> list = [];
    for (var item in itemList) {
      list.add(await insert(item));
    }
    return list;
  }

  Future<void> update({Map<String, dynamic>? item, List<Map<String, dynamic>>? itemList}) async {
    if (item != null){
      var id = 0;
        if (item.containsKey("id")){
          id = item["id"];
        item.remove("id");
      }
      await AppDatabase.get().database.update(this.tableName, item,where:"id=?",whereArgs: [id] );
    }

    if (itemList != null) {
      for (var item in itemList) {
        await update(item: item);
      }
    }
  }

  Future <void> insertOrUpdate({Map<String, dynamic>? item, List<Map<String, dynamic>>? itemList}) async {
    if (item != null) {
      int id = await insert(item);
      if (id == -1) await update(item: item);
    }
    if (itemList != null) {
      List<int> resultList = await insertList(itemList);
      List<Map<String, dynamic>> list = [];
      for (int i = 0; i < resultList.length; i++) {
        if (resultList[i] == -1) list.add(itemList[i]);
        if (list.length > 0) await update(itemList: list);
      }
    }
  }
}
