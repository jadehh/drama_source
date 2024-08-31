/*
 * @Author: jadehh
 * @Date: 2024-08-22 09:30:28
 * @LastEditTime: 2024-08-22 09:50:02
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\bean\parse_url.dart
 * 
 */

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/ext.dart';
import 'package:drama_source_core/src/model/language/local.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:drama_source_core/src/utils/url_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'k_parse.g.dart';

@JsonSerializable()
class KParse {
  @JsonKey(name: "name")
  late String? j_name;
  @JsonKey(name: "type")
  late int? j_type;
  @JsonKey(name: "url")
  late String? j_url;
  @JsonKey(name: "ext")
  late Ext? j_ext;
  @JsonKey(name: "activated")
  late bool? j_activated;
  @JsonKey(name: "click")
  late String? j_click;

  KParse({String? name,int type = 0,String? url,Ext? ext,bool activated=false,String? click}) {
    this.j_name = name;
    this.j_type = type;
    this.j_url = url;
    this.j_ext = ext;
    this.j_activated = activated;
    this.j_click = click;
  }

  factory KParse.fromJson(Map<String, dynamic> json) => _$KParseFromJson(json);

  Map<String, dynamic> toJson() => _$KParseToJson(this);

  static KParse get({String? name, int? type, String? url}) {
    KParse parse = KParse();
    if (name != null) parse.setName(name);
    if (type != null) parse.setType(type);
    if (url != null) parse.setUrl(url);
    return parse;
  }

  static KParse god() {
    KParse parse = new KParse();
    parse.setName(Local.parse_god);
    parse.setType(4);
    return parse;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  void setName(String name) {
    this.j_name = name;
  }

  int getType() {
    return j_type == null ? 0 : j_type!;
  }

  void setType(int type) {
    this.j_type = type;
  }

  Future<String> getUrl() async {
    return TextUtils.isEmpty(j_url) ? "" : await UrlUtil.convert(j_url!);
  }

  void setUrl(String url) {
    this.j_url = url;
  }

  Ext getExt() {
    return j_ext = j_ext == null ? new Ext() : j_ext!;
  }

  bool? isActivated() {
    return j_activated;
  }

  void setActivated({bool? activated, KParse? item}) {
    if (activated != null) this.j_activated = activated;
    if (item != null) this.j_activated = item.equals(this);
  }

  String getClick() {
    return TextUtils.isEmpty(j_click) ?  "" : j_click!;
  }

  void setClick(String click) {
    this.j_click = click;
  }

  Map<String, String>? getHeaders() {
    return Json.toMap(json: (getExt().getHeader()));
  }

  void setHeader(Map<String, String> header) {
    if (getExt().getHeader() == null) getExt().setHeader(header);
  }

  Future<bool> isEmpty() async {
    var urlStr = await getUrl();
    return getType() == 0 && await urlStr.isEmpty;
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is KParse)) return false;
    return getName() == obj.getName();
  }

  Future<String> extUrl() async {
    var urlStr = await getUrl();
    int index = urlStr.indexOf("?");
    if (getExt().isEmpty() || index == -1) return urlStr;
    return urlStr.substring(0, index + 1) +
        "cat_ext=" +
        Util.base64ToStr(s: getExt().toString()) +
        "&" +
        urlStr.substring(index + 1);
  }

  Future<Map<String, String>> mixMap() async {
    Map<String, String> map = {};
    map["type"] = getType().toString();
    map["ext"] = getExt().toString();
    var urlStr = await getUrl();
    map["url"] = urlStr;
    return map;
  }
}
