/*
 * @File     : site_dao.dart
 * @Author   : jade
 * @Date     : 2024/08/21 08:27:26
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */





import 'package:drama_source_core/src/api/bean/site.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_core/src/model/db/dao/base_dao.dart';

class SiteDao extends BaseDao{
  String tableName;

  static final SiteDao _instance = SiteDao._internal(AppDatabase.siteTableName);

  static SiteDao get instance => _instance;

  factory SiteDao() {
    return _instance;
  }

  SiteDao._internal(this.tableName) : super(tableName);

  static SiteDao get() {
    return _instance;
  }


  Future<Site?> find(String key) async{
    return null;
  }
}
