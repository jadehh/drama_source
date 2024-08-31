/*
 * @File     : live.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午9:12
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:io';
import 'dart:math';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/catch_up.dart';
import 'package:drama_source_core/src/api/bean/channel.dart';
import 'package:drama_source_core/src/api/bean/core.dart';
import 'package:drama_source_core/src/api/bean/group.dart';
import 'package:drama_source_core/src/constant.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path;


part 'live.g.dart';

@JsonSerializable()
class Live {
  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "type")
  late int? j_type;

  @JsonKey(name: "group")
  late String? j_group;

  @JsonKey(name: "url")
  late String? j_url;

  @JsonKey(name: "jar")
  late String? j_jar;

  @JsonKey(name: "logo")
  late String? j_logo;

  @JsonKey(name: "epg")
  late String? j_epg;

  @JsonKey(name: "ua")
  late String? j_ua;

  @JsonKey(name: "click")
  late String? j_click;

  @JsonKey(name: "origin")
  late String? j_origin;

  @JsonKey(name: "referer")
  late String? j_referer;

  @JsonKey(name: "timeout")
  late int? j_timeout;

  @JsonKey(name: "header")
  late Map<String, dynamic>? j_header;

  @JsonKey(name: "playerType")
  late int? j_playerType;

  @JsonKey(name: "channels")
  List<Channel>? j_channels;

  @JsonKey(name: "groups")
  List<Group>? j_groups;

  @JsonKey(name: "catchup")
  late Catchup? j_catchup;

  @JsonKey(name: "core")
  late Core? j_core;

  @JsonKey(name: "boot",defaultValue: false)
  late bool? j_boot;

  @JsonKey(name: "pass")
  late bool? j_pass;

  @JsonKey(name: "activated")
  bool? j_activated;

  @JsonKey(name: "width")
  int? j_width;

  Live({String? name, int type = 0, String? group, String? url, String? jar, String? logo, String? epg, String? ua, String? click,
        String? origin, String? referer, int? timeout, Map<String, dynamic>? header, int? playType, List<Channel>? channels, List<Group>? groups, Catchup? catchup, Core? core, bool boot = false, bool pass = false, bool activated = false, int width=0}) {
    if (url != null)
      this.j_name = url.startsWith("file") ? path.basename(url) : Uri.parse(url).pathSegments.last;
    else
      this.j_name = name;
    this.j_url = url;
    this.j_type = type;
    this.j_group = group;
    this.j_jar = jar;
    this.j_logo = logo;
    this.j_epg = epg;
    this.j_ua = ua;
    this.j_click = click;
    this.j_origin = origin;
    this.j_referer = referer;
    this.j_timeout = timeout;
    this.j_header = header;
    this.j_playerType = playType;
    this.j_channels = channels;
    this.j_groups = groups;
    this.j_catchup = catchup;
    this.j_core = core;
    this.j_boot = boot;
    this.j_pass = pass;
    this.j_activated = activated;
    this.j_width = width;
  }

  factory Live.fromJson(Map<String, dynamic> json) => _$LiveFromJson(json);

  Map<String, dynamic> toJson() => _$LiveToJson(this);

  int getType() {
    return j_type!;
  }

  bool isBoot() {
    return j_boot!;
  }

  void setBoot(bool boot) {
    this.j_boot = boot;
  }

  bool isPass() {
    return j_pass!;
  }

  void setPass(bool pass) {
    this.j_pass = pass;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  void setName(String name) {
    this.j_name = name;
  }

  String getGroup() {
    return TextUtils.isEmpty(j_group) ? "" : j_group!;
  }

  String getUrl() {
    return TextUtils.isEmpty(j_url) ? "" : j_url!;
  }

  String getJar() {
    return TextUtils.isEmpty(j_jar) ? "" : j_jar!;
  }

  String getLogo() {
    return TextUtils.isEmpty(j_logo) ? "" : j_logo!;
  }

  String getEpg() {
    return TextUtils.isEmpty(j_epg) ? "" : j_epg!;
  }

  void setEpg(String epg) {
    this.j_epg = epg;
  }

  String getUa() {
    return TextUtils.isEmpty(j_ua) ? "" : j_ua!;
  }

  String getOrigin() {
    return TextUtils.isEmpty(j_origin) ? "" : j_origin!;
  }

  String getReferer() {
    return TextUtils.isEmpty(j_referer) ? "" : j_referer!;
  }

  String getClick() {
    return TextUtils.isEmpty(j_click) ? "" : j_click!;
  }

  int getTimeout() {
    return j_timeout == null ? Constant.TIMEOUT_PLAY : max(j_timeout!, 1)*1000;
  }

  Map<String, dynamic>? getHeader() {
    return j_header;
  }

  int getPlayerType() {
    return j_playerType == null ? -1 : min(j_playerType!, 2);
  }

  List<Channel> getChannels() {
    return j_channels = j_channels == null ? [] : j_channels!;
  }

  List<Group> getGroups() {
    return j_groups = j_groups == null ? [] : j_groups!;
  }

  Catchup getCatchup() {
    return j_catchup == null ?  Catchup() : j_catchup!;
  }

  Core getCore() {
    return j_core == null ?  Core() : j_core!;
  }

  bool isActivated() {
    return j_activated!;
  }

  void setActivated({bool? activated,Live? item}) {
    if (activated != null) this.j_activated = activated;
    if (item != null) this.j_activated = item.equals(this);
  }

  int getWidth() {
    return j_width!;
  }

  void setWidth(int width) {
    this.j_width = width;
  }

  bool isEmpty() {
    return getName().isEmpty;
  }

  Live check() {
    bool proxy = getChannels().length > 0 && getChannels()[0].getUrls().length > 0 && getChannels()[0].getUrls()[0].startsWith("proxy");
    if (proxy) setProxy();
    return this;
  }

  void setProxy() {
    this.j_url = getChannels()[0].getUrls()[0];
    this.j_name = getChannels()[0].getName();
    this.j_type = 2;
  }

  Group gfind(Group item) {
    for (Group group in getGroups()) if (group.getName() == item.getName()) return group;
    getGroups().add(item);
    return item;
  }

  int getBootIcon() {
    return isBoot() ? 0:1;
  }

  int getPassIcon() {
    return isPass() ? 0:1;
  }

  Live boot(bool boot) {
    setBoot(boot);
    return this;
  }

  Live pass(bool pass) {
    getGroups().clear();
    setPass(pass);
    return this;
  }

  Future<Live> sync() async{
    Live? item = await find(getName());
    if (item == null) return this;
    setBoot(item.isBoot());
    setPass(item.isPass());
    return this;
  }

  Map<String, String> getHeaders() {
    Map<String, String> headers = Json.toMap(json: getHeader());
    if (getUa().isNotEmpty) headers[HttpHeaders.userAgentHeader] =  getUa();
    if (getOrigin().isNotEmpty) headers["Origin"] = getOrigin();
    if (getReferer().isNotEmpty) headers[HttpHeaders.refererHeader] = getReferer();
    return headers;
  }

  static Future<Live?> find(String name) async {
    return await AppDatabase.get().getLiveDao().find(name);
  }

  void save() {
    AppDatabase.get().getLiveDao().insertOrUpdate(item: this.toJson());
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Live)) return false;
    return getName() == obj.getName();
  }
}