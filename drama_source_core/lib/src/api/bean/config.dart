/*
 * @Author: jadehh
 * @Date: 2024-08-15 11:12:46
 * @LastEditTime: 2024-08-22 13:09:08
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\bean\config.dart
 * 
 */


import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/api/bean/depot.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  @JsonKey(name: "id")
  int? j_id ;
  @JsonKey(name: "type")
  int? j_type;
  @JsonKey(name: "time")
  int? j_time;
  @JsonKey(name: "url")
  String? j_url;
  @JsonKey(name: "name",defaultValue: "")
  String? j_name;
  @JsonKey(name: "json")
  String? j_json;
  @JsonKey(name: "logo")
  String? j_logo;
  @JsonKey(name: "home")
  String? j_home;
  @JsonKey(name: "parse")
  String? j_parse;

  Config({int id = 0,int type=0,int time=0,String? url,String? name,String? json,String? logo,String? home,String? parse}){
    this.j_id = id;
    this.j_type = type;
    this.j_time = time;
    this.j_url = url;
    this.j_name = name;
    this.j_json = json;
    this.j_logo = logo;
    this.j_home = home;
    this.j_parse = parse;
  }

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  static List<Config> arrayFrom(List<Map<String, Object?>> mapList) {
    List<Config> items = [];
    for (var element in mapList) {
      items.add(Config.fromJson(element));
    }
    return items;
  }

  static Config objectFrom(String str) {
    return Config.fromJson(str as Map<String, dynamic>);
  }

  static Future<Config> create({required int type, String? url, String? name}) async {
    Config config = Config().type(type);
    if (url != null) await config.url(url).insert();
    if (name != null) await config.name(name).insert();
    return config;
  }

  int getId() {
    return j_id!;
  }

  void setId(int id) {
    this.j_id = id;
  }

  int getType() {
    return j_type!;
  }

  void setType(int type) {
    this.j_type = type;
  }

  String? getUrl() {
    return j_url;
  }

  void setUrl(String url) {
    this.j_url = url;
  }

  String? getJson() {
    return j_json;
  }

  void setJson(String json) {
    this.j_json = json;
  }

  String? getName() {
    return j_name;
  }

  void setName(String? name) {
    this.j_name = name;
  }

  String? getLogo() {
    return j_logo;
  }

  void setLogo(String logo) {
    this.j_logo = logo;
  }

  String? getHome() {
    return j_home;
  }

  void setHome(String home) {
    this.j_home = home;
  }

  String? getParse() {
    return  j_parse;
  }

  void setParse(String parse) {
    this.j_parse = parse;
  }

  int getTime() {
    return j_time!;
  }

  void setTime(int time) {
    this.j_time = time;
  }

  bool isCache() {
    return getTime() + (3600 * 1000 * 12 * Setting.getConfigCache()) > DateTime.now().millisecondsSinceEpoch;
  }

  Config type(int type) {
    setType(type);
    return this;
  }

  Config url(String url) {
    setUrl(url);
    return this;
  }

  Config json(String json) {
    setJson(json);
    return this;
  }

  Config name(String? name) {
    setName(name);
    return this;
  }

  Config logo(String logo) {
    setLogo(logo);
    return this;
  }

  Config home(String home) {
    setHome(home);
    return this;
  }

  Config parse(String parse) {
    setParse(parse);
    return this;
  }

  bool isEmpty() {
    return TextUtils.isEmpty(getUrl());
  }

  String getDesc() {
    if (!TextUtils.isEmpty(getName())) return getName()!;
    if (!TextUtils.isEmpty(getUrl())) return getUrl()!;
    return "";
  }

  static Future<List<Config>?> getAll(int type) async {
    return await AppDatabase.get().getConfigDao().findByType(type);
  }

  static Future<List<Config>?> findUrls() async {
    return await AppDatabase.get().getConfigDao().findUrlByType(0);
  }

  static Future<void> delete({String? url, int? type}) async {
    await AppDatabase.get().getConfigDao().delete(url: url, type: type);
  }

  static Future<Config> vod() async {
    Config? item = await AppDatabase.get().getConfigDao().findOne(0);
    return item == null ? await create(type: 0) : item;
  }

  static Future<Config> live() async {
    Config? item = await AppDatabase.get().getConfigDao().findOne(1);
    return item == null ? await create(type: 1) : item;
  }

  static Future<Config> wall() async {
    Config? item = await AppDatabase.get().getConfigDao().findOne(2);
    return item == null ? await create(type: 2) : item;
  }

  static Future<Config?> find({int? id, String? url, String? name, int? type, Config? config, Depot? depot}) async {
    if (id != null) return await AppDatabase.get().getConfigDao().findById(id);
    if (url != null && type != null) {
      Config? item = await AppDatabase.get().getConfigDao().find(url, type);
      if (name != null) return item == null ? await create(type: type, url: url, name: name) : item.type(type).name(name);
      else return item == null ? await create(type: type, url: url) : item.type(type);
    }
    if (config != null) {
      if (type != null) {
        Config? item = await AppDatabase.get().getConfigDao().find(config.getUrl()!, type);
        return item == null ? await create(type: type, url: config.getUrl(), name: config.getName()) : item.type(type).name(config.getName());
      } else return await find(config: config, type: config.getType());
    }
    if (depot != null && type != null) {
      Config? item = await AppDatabase.get().getConfigDao().find(depot.getUrl(), type);
      return item == null ? await create(type: type, url: depot.getUrl(), name: depot.getName()) : item.type(type).name(depot.getName());
    }
    return null;
  }

  Future<Config> insert() async {
    if (isEmpty()) return this;
    setId(await AppDatabase.get().getConfigDao().insert(this.toJson()));
    return this;
  }

  Future<Config> save() async {
    if (isEmpty()) return this;
    await AppDatabase.get().getConfigDao().update(item: this.toJson());
    return this;
  }

  Future<Config> update() async {
    if (isEmpty()) return this;
    setTime(DateTime.now().millisecondsSinceEpoch);
    await Prefers.put("config_" + getType().toString(), getUrl());
    return await save();
  }

  Future<void> innerDelete() async {
    await AppDatabase.get().getConfigDao().delete(url: getUrl(), type: getType());
    // History.delete(getId());
    // Keep.delete(getId());
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Config)) return false;
    return getId() == obj.getId();
  }
}
