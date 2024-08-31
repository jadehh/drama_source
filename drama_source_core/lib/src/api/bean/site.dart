/*
 * @Author: jadehh
 * @Date: 2024-08-21 14:18:49
 * @LastEditTime: 2024-08-22 09:40:52
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\bean\site.dart
 * 
 */

import 'dart:math';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/style.dart';
import 'package:drama_source_core/src/constant.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_core/src/model/setting.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'site.g.dart';

@JsonSerializable()
class Site {
  @JsonKey(name: "key", required: true)
  late String? j_key;

  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "api", required: true)
  late String? j_api;

  @JsonKey(name: "ext", fromJson: extToJson)
  late String? j_ext;

  @JsonKey(name: "jar")
  late String? j_jar;

  @JsonKey(name: "click")
  late String? j_click;

  @JsonKey(name: "playUrl")
  late String? j_playUrl;

  @JsonKey(name: "type")
  late int? j_type;

  @JsonKey(name: "indexs")
  late int? j_indexs;

  @JsonKey(name: "timeout")
  late int? j_timeout;

  @JsonKey(name: "playerType")
  late int? j_playerType;

  @JsonKey(name: "searchable")
  late int? j_searchable;

  @JsonKey(name: "changeable")
  late int? j_changeable;

  @JsonKey(name: "categories")
  late List<String>? j_categories;

  @JsonKey(name: "header",defaultValue: "")
  late Map<String, dynamic>? j_header;

  @JsonKey(name: "style")
  late Style? j_style;

  @JsonKey(name: "activated")
  late bool? j_activated;


  Site({String? key,String? name,String? api,String? ext,String? jar,String? click,String? playUrl,
    int type=0,int indexs=0,int timeout=0, int playerType=0,int searchable = 0,int changeable = 0,
    List<String>? categories,Map<String, dynamic>? header,Style? style,bool activated=false
  }) {
    this.j_key = key;
    this.j_name = name;
    this.j_api = api;
    this.j_ext = ext;
    this.j_jar = jar;
    this.j_click = click;
    this.j_playUrl = playUrl;
    this.j_type = type;
    this.j_indexs = indexs;
    this.j_timeout = timeout;
    this.j_playerType = playerType;
    this.j_searchable = searchable;
    this.j_changeable = changeable;
    this.j_categories = categories;
    this.j_header = header;
    this.j_style = style;
    this.j_activated = activated;
  }

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);

  Map<String, dynamic> toJson() => _$SiteToJson(this);

  static Site get({String? key, String? name}) {
    Site site = Site();
    if (key != null) site.setKey(key);
    if (name != null) site.setName(name);
    return site;
  }

  String getKey() {
    return TextUtils.isEmpty(j_key) ? "" : j_key!;
  }

  void setKey(String key) {
    this.j_key = key;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  void setName(String name) {
    this.j_name = name;
  }

  String getApi() {
    return TextUtils.isEmpty(j_api) ? "" : j_api!;
  }

  void setApi(String api) {
    this.j_api = api;
  }

  String getExt() {
    return TextUtils.isEmpty(j_ext) ? "" : j_ext!;
  }

  void setExt(String ext) {
    this.j_ext = ext.trim();
  }

  String getJar() {
    return TextUtils.isEmpty(j_jar) ? "" : j_jar!;
  }

  String getClick() {
    return TextUtils.isEmpty(j_click) ? "" : j_click!;
  }

  String getPlayUrl() {
    return TextUtils.isEmpty(j_playUrl) ? "" : j_playUrl!;
  }

  int getType() {
    return j_type == null ? 0 : j_type!;
  }

  int getTimeout() {
    return j_timeout == null ? Constant.TIMEOUT_PLAY : max(j_timeout!, 1) * 1000;
  }

  int getPlayerType() {
    return j_playerType == null ? -1 : min(j_playerType!, 2);
  }

  int getSearchable() {
    return j_searchable == null ? 1 : j_searchable!;
  }

  void setSearchable(int searchable) {
    this.j_searchable = searchable;
  }

  int getChangeable() {
    return j_changeable == null ? 1 : j_changeable!;
  }

  void setChangeable(int changeable) {
    this.j_changeable = changeable;
  }

  bool isIndexs() {
    return getIndexs() == 1;
  }

  int getIndexs() {
    if (Setting.isAggregatedSearch() && (j_indexs == null || j_indexs == 1)) return 1;
    return j_indexs == null ? 0 : j_indexs!;
  }

  List<String> getCategories() {
    return j_categories == null ? [] : j_categories!;
  }

  void setCategories(List<String> categories) {
    this.j_categories = categories;
  }

  Map<String, dynamic>? getHeader() {
    return j_header;
  }

  Style? getStyle({Style? style}) {
    if (style != null)
      return getStyle() != null ? getStyle() : style;
    return j_style;
  }

  bool? isActivated() {
    return j_activated;
  }

  void setActivated({bool? activated, Site? item}) {
    if (item != null) this.j_activated = item.equals(this);
    if (activated != null) this.j_activated = activated;
  }

  bool isSearchable() {
    return getSearchable() == 1;
  }

  Site setSiteSearchable(bool searchable) {
    if (getSearchable() != 0) setSearchable(searchable ? 1 : 2);
    return this;
  }

  bool isChangeable() {
    return getChangeable() == 1;
  }

  Site setSiteChangeable(bool changeable) {
    if (getChangeable() != 0) setChangeable(changeable ? 1 : 2);
    return this;
  }

  bool isEmpty() {
    return getKey().isEmpty && getName().isEmpty;
  }

  Map<String, String> getHeaders() {
    return Json.toMap(json: getHeader());
  }

  Site trans() {
    if (Trans.pass()) return this;
    List<String> categories = [];
    for (String cate in getCategories()) categories.add(Trans.s2t(cate));
    setCategories(categories);
    return this;
  }

  Future<Site> sync() async {
    Site? item = await find(getKey());
    if (item == null) return this;
    if (getChangeable() != 0) setChangeable(max(1, item.getChangeable()));
    if (getSearchable() != 0) setSearchable(max(1, item.getSearchable()));
    return this;
  }

  static Future<Site?> find(String key) async {
    return await AppDatabase.get().getSiteDao().find(key);
  }

  Future<void> save() async {
    await AppDatabase.get().getSiteDao().insertOrUpdate(item: this.toJson());
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Site)) return false;
    return getKey() == obj.getKey();
  }
}

String extToJson(Map<String,dynamic> ext){
  return ext.toString();
}