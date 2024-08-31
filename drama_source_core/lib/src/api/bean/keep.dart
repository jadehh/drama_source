/*
 * @File     : keep.dart
 * @Author   : jade
 * @Date     : 2024/8/28 上午11:13
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keep.g.dart';

@JsonSerializable()
class Keep {
  @JsonKey(name: "key")
  late String? j_key;

  @JsonKey(name: "siteName")
  late String? j_siteName;

  @JsonKey(name: "vodName")
  late String? j_vodName;

  @JsonKey(name: "vodPic")
  late String? j_vodPic;

  @JsonKey(name: "createTime")
  late int? j_createTime;

  @JsonKey(name: "type")
  late int? j_type;

  @JsonKey(name: "cid")
  late int? j_cid;

  Keep({String key = "", String siteName = "", String vodName = "", String vodPic = "", int createTime = 0, int type = 0, int cid = 0}) {
      this.j_key = key;
      this.j_siteName = siteName;
      this.j_vodName = vodName;
      this.j_vodPic = vodPic;
      this.j_createTime = createTime;
      this.j_type = type;
      this.j_cid = cid;
  }


  factory Keep.fromJson(Map<String, dynamic> json) => _$KeepFromJson(json);

  Map<String, dynamic> toJson() => _$KeepToJson(this);

  String getKey() {
    return j_key !;
  }

  void setKey(String key) {
    this.j_key = key;
  }

  String getSiteName() {
    return j_siteName!;
  }

  void setSiteName(String siteName) {
    this.j_siteName = siteName;
  }

  String getVodName() {
    return j_vodName!;
  }

  void setVodName(String vodName) {
    this.j_vodName = vodName;
  }

  String getVodPic() {
    return j_vodPic!;
  }

  void setVodPic(String vodPic) {
    this.j_vodPic = vodPic;
  }

  int getCreateTime() {
    return j_createTime!;
  }

  void setCreateTime(int createTime) {
    this.j_createTime = createTime;
  }

  int getType() {
    return j_type!;
  }

  void setType(int type) {
    this.j_type = type;
  }

  int getCid() {
    return j_cid!;
  }

  void setCid(int cid) {
    this.j_cid = cid;
  }

  String getSiteKey() {
    return getKey().split(AppDatabase.SYMBOL)[0];
  }

  String getVodId() {
    return getKey().split(AppDatabase.SYMBOL)[1];
  }

  static Future<Keep?> find(String key,{int? cid}) async {
    return await AppDatabase.get().getKeepDao().find(key,cid: cid);
  }


  static Future<bool> exist(String key) async {
    return await AppDatabase.get().getKeepDao().find(key) != null;
  }

  static Future deleteAll() async {
    await AppDatabase.get().getKeepDao().delete();
  }

  static Future<List<Keep>?> getVod() async{
     return await AppDatabase.get().getKeepDao().getVod();
  }

  static Future<List<Keep>?> getLive() async{
    return await AppDatabase.get().getKeepDao().getLive();
  }

  Future save({int? cid}) async {
    if (cid != null) {
      setCid(cid);
      await AppDatabase.get().getKeepDao().insertOrUpdate(item: this.toJson());
    }
    else
      await AppDatabase.get().getKeepDao().insert(this.toJson());
  }


  Keep delete({int? cid, String? key}) {
    if (cid == null && key == null)
      AppDatabase.get().getKeepDao().delete(cid: getCid(), key: getKey());
    else
      AppDatabase.get().getKeepDao().delete(cid: cid, key: key);
    return this;
  }

  static Future startSync(List<Config> configs, List<Keep> targets) async {
    for (Keep target in targets) {
      for (Config config in configs) {
        if (target.getCid() == config.getId()) {
          await target.save(cid: (await Config.find(config: config, type: 0))!.getId());
        }
      }
    }
  }

  static void sync(List<Config> configs, List<Keep> targets) {
    startSync(configs, targets);
    RefreshEvent.keep();
  }
}
