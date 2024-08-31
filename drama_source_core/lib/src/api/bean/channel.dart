/*
 * @File     : channel.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午9:36
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'dart:io';
import 'dart:math';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/api/bean/catch_up.dart';
import 'package:drama_source_core/src/api/bean/drm.dart';
import 'package:drama_source_core/src/api/bean/epg.dart';
import 'package:drama_source_core/src/api/bean/group.dart';
import 'package:drama_source_core/src/api/bean/live.dart';
import 'package:drama_source_core/src/api/bean/result.dart';
import 'package:drama_source_core/src/api/bean/url.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprintf/sprintf.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  @JsonKey(name: "urls")
  late List<String>? j_urls;

  @JsonKey(name: "tvgName")
  late String? j_tvgName;

  @JsonKey(name: "number")
  late String? j_number;

  @JsonKey(name: "logo")
  late String? j_logo;

  @JsonKey(name: "epg")
  late String? j_epg;

  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "ua")
  late String? j_ua;

  @JsonKey(name: "click")
  late String? j_click;

  @JsonKey(name: "format")
  late String? j_format;

  @JsonKey(name: "origin")
  late String? j_origin;

  @JsonKey(name: "referer")
  late String? j_referer;

  @JsonKey(name: "catchup")
  late Catchup? j_catchup;

  @JsonKey(name: "header")
  late Map<String, dynamic>? j_header;

  @JsonKey(name: "playerType")
  late int? j_playerType;

  @JsonKey(name: "parse")
  late int? j_parse;

  @JsonKey(name: "drm")
  late Drm? j_drm;

  @JsonKey(name: "selected")
  late bool? j_selected;
  @JsonKey(name: "group")
  late Group? j_group;
  @JsonKey(name: "url")
  late String? j_url;
  @JsonKey(name: "msg")
  late String? j_msg;
  @JsonKey(name: "data")
  late Epg? j_data;
  @JsonKey(name: "line")
  late int? j_line;

  Channel(
      {List<String>? urls,
      String? tvgName,
      String? number,
      String? logo,
      String? epg,
      String? name,
      String? ua,
      String? click,
      String? format,
      String? origin,
      String? referer,
      Catchup? catchup,
      Map<String, dynamic>? header,
      int? playerType,
      int? parse,
      Drm? drm,
      bool? selected,
      Group? group,
      String? url,
      String? msg,
      Epg? data,
      int line=0}) {
    this.j_url = url;
    this.j_tvgName = tvgName;
    this.j_number = number;
    this.j_logo = logo;
    this.j_epg = epg;
    this.j_name = name;
    this.j_ua = ua;
    this.j_click = click;
    this.j_format = format;
    this.j_origin = origin;
    this.j_referer = referer;
    this.j_catchup = catchup;
    this.j_header = header;
    this.j_playerType = playerType;
    this.j_parse = j_parse;
    this.j_drm = drm;
    this.j_selected = selected;
    this.j_group = group;
    this.j_url = url;
    this.j_msg = msg;
    this.j_data = data;
    this.j_line = line;
  }

  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);

  static Channel? create({int? number, String? name, Channel? channel}) {
    if (number != null) return Channel().setNumber(number: number);
    if (name != null) return Channel(name: name);
    if (channel != null) return Channel().copy(channel);
    return null;
  }

  static Channel error(String msg) {
    Channel result = Channel();
    result.setMsg(msg);
    return result;
  }

  String getTvgName() {
    return TextUtils.isEmpty(j_tvgName) ? getName() : j_tvgName!;
  }

  void setTvgName(String tvgName) {
    this.j_tvgName = tvgName;
  }

  List<String> getUrls() {
    return j_urls = j_urls == null ? [] : j_urls!;
  }

  void setUrls(List<String> urls) {
    this.j_urls = urls;
  }

  String getNumber() {
    return TextUtils.isEmpty(j_number) ? "" : j_number!;
  }

  Channel setNumber({String? numberStr,int? number}) {
    if (numberStr != null) this.j_number = numberStr;
    setNumber(numberStr: sprintf("${Platform.localeName}%03d",number));
    return this;
  }

  String getLogo() {
    return TextUtils.isEmpty(j_logo) ? "" : j_logo!;
  }

  void setLogo(String logo) {
    this.j_logo = logo;
  }

  String getEpg() {
    return TextUtils.isEmpty(j_epg) ? "" : j_epg!;
  }

  void setEpg(String epg) {
    this.j_epg = epg;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  void setName(String name) {
    this.j_name = name;
  }

  String getUa() {
    return TextUtils.isEmpty(j_ua) ? "" : j_ua!;
  }

  void setUa(String ua) {
    this.j_ua = ua;
  }

  String getClick() {
    return TextUtils.isEmpty(j_click) ? "" : j_click!;
  }

  void setClick(String click) {
    this.j_click = click;
  }

  String getFormat() {
    return TextUtils.isEmpty(j_format) ? "" : j_format!;
  }

  void setFormat(String format) {
    this.j_format = format;
  }

  String getOrigin() {
    return TextUtils.isEmpty(j_origin) ? "" : j_origin!;
  }

  void setOrigin(String origin) {
    this.j_origin = origin;
  }

  String getReferer() {
    return TextUtils.isEmpty(j_referer) ? "" : j_referer!;
  }

  void setReferer(String referer) {
    this.j_referer = referer;
  }

  Catchup getCatchup() {
    return j_catchup == null ? new Catchup() : j_catchup!;
  }

  void setCatchup(Catchup catchup) {
    this.j_catchup = catchup;
  }

  Map<String, dynamic>? getHeader() {
    return j_header;
  }

  void setHeader(Map<String, dynamic> header) {
    this.j_header = header;
  }

  int getPlayerType() {
    return j_playerType == null ? -1 : min(j_playerType!, 2);
  }

  void setPlayerType(int playerType) {
    this.j_playerType = playerType;
  }

  int getParse() {
    return j_parse == null ? 0 : j_parse!;
  }

  void setParse(int parse) {
    this.j_parse = parse;
  }

  Drm getDrm() {
    return j_drm!;
  }

  void setDrm(Drm drm) {
    this.j_drm = drm;
  }

  Group? getGroup() {
    return j_group;
  }

  void setGroup(Group group) {
    this.j_group = group;
  }

  String getUrl() {
    return TextUtils.isEmpty(j_url) ? "" : j_url!;
  }

  void setUrl(String url) {
    this.j_url = url;
  }

  String getMsg() {
    return TextUtils.isEmpty(j_msg) ? "" : j_msg!;
  }

  void setMsg(String msg) {
    this.j_msg = msg;
  }

  bool hasMsg() {
    return getMsg().length > 0;
  }

  Epg getData() {
    return j_data == null ? new Epg() : j_data!;
  }

  void setData(Epg data) {
    this.j_data = data;
  }

  int getLine() {
    return j_line!;
  }

  void setLine({int? line,String? lineStr}) {
    if (line != null) this.j_line = max(line, 0);
    if (lineStr != null) setLine(line: getUrl().indexOf(lineStr));
  }

  bool isSelected() {
    return j_selected!;
  }

  void setSelected({bool? selected, Channel? item}) {
    if (selected != null) this.j_selected = selected;
    if (item != null) this.j_selected = item.equals(this);
  }

  int getLineVisible() {
    return isOnly() ? 0 : 1;
  }

  // void loadLogo(ImageView view) {
  //   ImgUtil.loadLive(getLogo(), view);
  // }

  void addUrls(List<String> urls) {
    getUrls().addAll(urls);
  }

  void nextLine() {
    setLine(line: getLine() < getUrls().length - 1 ? getLine() + 1 : 0);
  }

  void prevLine() {
    setLine(line: getLine() > 0 ? getLine() - 1 : getUrls().length - 1);
  }

  String getCurrent() {
    return getUrls().isEmpty ? "" : getUrls()[getLine()];
  }

  bool isOnly() {
    return getUrls().length == 1;
  }

  bool isLast() {
    return getUrls().isEmpty || getLine() == getUrls().length - 1;
  }

  bool hasCatchup() {
    if (getCatchup().isEmpty() && getCurrent().contains("/PLTV/"))
      setCatchup(Catchup.PLTV());
    if (!getCatchup().getRegex().isEmpty)
      return getCatchup().match(getCurrent());
    return !getCatchup().isEmpty();
  }

  String getLineText() {
    if (getUrls().length <= 1) return "";
    if (getCurrent().contains(r"$")) return getCurrent().split(r"\\$")[1];
    return sprintf(Local.live_line,(getLine() + 1).toString());
  }

  Channel group(Group group) {
    setGroup(group);
    return this;
  }

  void live(Live live) {
    if (live.getUa().length > 0 && getUa().isEmpty) setUa(live.getUa());
    if (live.getHeader() != null && getHeader() == null)
      setHeader(live.getHeader()!);
    if (live.getClick().length > 0 && getClick().isEmpty)
      setClick(live.getClick());
    if (live.getOrigin().length > 0 && getOrigin().isEmpty)
      setOrigin(live.getOrigin());
    if (!live.getCatchup().isEmpty() && getCatchup().isEmpty())
      setCatchup(live.getCatchup());
    if (live.getReferer().length > 0 && getReferer().isEmpty)
      setReferer(live.getReferer());
    if (live.getPlayerType() != -1 && getPlayerType() == -1)
      setPlayerType(live.getPlayerType());
    if (!getEpg().startsWith("http") && live.getEpg().contains("{"))
      setEpg(live.getEpg().replaceAll("{name}", getTvgName()).replaceAll("{epg}", getEpg()));
    if (!getLogo().startsWith("http") && live.getLogo().contains("{"))
      setLogo(live.getLogo().replaceAll("{name}", getTvgName()).replaceAll("{logo}", getLogo()));
  }



  Map<String, String> getHeaders() {
    Map<String, String> headers = Json.toMap(json: getHeader());
    if (!getUa().isEmpty) headers[HttpHeaders.userAgentHeader] =  getUa();
    if (!getOrigin().isEmpty) headers["Origin"] =  getOrigin();
    if (!getReferer().isEmpty) headers[HttpHeaders.refererHeader] = getReferer();
    return headers;
  }

  Channel copy(Channel item) {
    setPlayerType(item.getPlayerType());
    setCatchup(item.getCatchup());
    setReferer(item.getReferer());
    setTvgName(item.getTvgName());
    setHeader(item.getHeader()!);
    setNumber(numberStr: item.getNumber());
    setOrigin(item.getOrigin());
    setFormat(item.getFormat());
    setParse(item.getParse());
    setClick(item.getClick());
    setLogo(item.getLogo());
    setName(item.getName());
    setUrls(item.getUrls());
    setData(item.getData());
    setDrm(item.getDrm());
    setEpg(item.getEpg());
    setUa(item.getUa());
    return this;
  }

  Result result() {
    Result result = new Result();
    result.setClick(getClick());
    result.setUrl(url: Url.create().add(v: getUrl()));
    result.setHeader(getHeaders());
    return result;
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Channel)) return false;
    return getName() == obj.getName() || (!getNumber().isEmpty && getNumber() == obj.getNumber());
  }
}
