/*
 * @File     : vod.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午2:42
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/api/bean/cate.dart';
import 'package:drama_source_core/src/api/bean/flag.dart';
import 'package:drama_source_core/src/api/bean/style.dart';
import 'package:drama_source_core/src/utils/sniffer.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vod.g.dart';

@JsonSerializable()
class Vod {
  @JsonKey(name: "vod_id")
  late String? vodId;

  @JsonKey(name: "vod_name")
  late String? vodName;

  @JsonKey(name: "type_name")
  late String? typeName;

  @JsonKey(name: "vod_pic")
  late String? vodPic;

  @JsonKey(name: "vod_remarks")
  late String? vodRemarks;

  @JsonKey(name: "vod_year")
  late String? vodYear;

  @JsonKey(name: "vod_area")
  late String? vodArea;

  @JsonKey(name: "vod_director")
  late String? vodDirector;

  @JsonKey(name: "vod_actor")
  late String? vodActor;

  @JsonKey(name: "vod_content")
  late String? vodContent;

  @JsonKey(name: "vod_play_from")
  late String? vodPlayFrom;

  @JsonKey(name: "vod_play_url")
  late String? vodPlayUrl;

  @JsonKey(name: "vod_tag")
  late String? vodTag;

  @JsonKey(name: "cate")
  late Cate? j_cate;

  @JsonKey(name: "style")
  late Style? j_style;

  @JsonKey(name: "land")
  late int? j_land;

  @JsonKey(name: "circle")
  late int? j_circle;

  @JsonKey(name: "ratio")
  late double? j_ratio;

  @JsonKey(name: "vodFlags")
  List<Flag>? j_vodFlags;

  @JsonKey(name: "site")
  late Site? j_site;

  Vod(
      {String? vod_id,
      String? vod_name,
      String? type_name,
      String? vod_pic,
      String? vod_remarks,
      String? vod_year,
      String? vod_area,
      String? vod_director,
      String? vod_actor,
      String? vod_content,
      String? vod_play_from,
      String? vod_play_url,
      String? vod_tag,
      Cate? cate,
      Style? style,
      int land = 0,
      int circle = 0,
      double ratio = 0,
      List<Flag>? vodFlags,
      Site? site}) {
    this.vodId = vod_id;
    this.vodName = vod_name;
    this.typeName = type_name;
    this.vodPic = vod_pic;
    this.vodRemarks = vod_remarks;
    this.vodYear = vod_year;
    this.vodArea = vod_area;
    this.vodDirector = vod_director;
    this.vodActor = vod_actor;
    this.vodContent = vod_content;
    this.vodPlayFrom = vod_play_from;
    this.vodPlayUrl = vod_play_url;
    this.vodTag = vod_tag;
    this.j_cate = cate;
    this.j_style = style;
    this.j_land = land;
    this.j_circle = circle;
    this.j_ratio = ratio;
    this.j_vodFlags = vodFlags;
    this.j_site = site;
  }

  factory Vod.fromJson(Map<String, dynamic> json) => _$VodFromJson(json);

  Map<String, dynamic> toJson() => _$VodToJson(this);

  String getVodId() {
    return TextUtils.isEmpty(vodId) ? "" : vodId!.trim();
  }

  void setVodId(String vodId) {
    this.vodId = vodId;
  }

  String getVodName({String? name}) {
    if (name != null) {
      if (!TextUtils.isEmpty(name)) setVodName(name);
      return getVodName();
    } else return TextUtils.isEmpty(vodName) ? "" : vodName!.trim();
  }

  void setVodName(String vodName) {
    this.vodName = vodName;
  }

  String getTypeName() {
    return TextUtils.isEmpty(typeName) ? "" : typeName!.trim();
  }

  String getVodPic({String? pic}) {
    if (pic != null) {
      if (getVodPic().isEmpty) setVodPic(pic);
      return getVodPic();
    } else return TextUtils.isEmpty(vodPic) ? "" : vodPic!.trim();
  }

  void setVodPic(String vodPic) {
    this.vodPic = vodPic;
  }

  String getVodRemarks() {
    return TextUtils.isEmpty(vodRemarks) ? "" : vodRemarks!.trim();
  }

  String getVodYear() {
    return TextUtils.isEmpty(vodYear) ? "" : vodYear!.trim();
  }

  String getVodArea() {
    return TextUtils.isEmpty(vodArea) ? "" : vodArea!.trim();
  }

  String getVodDirector() {
    return TextUtils.isEmpty(vodDirector) ? "" : vodDirector!.trim();
  }

  String getVodActor() {
    return TextUtils.isEmpty(vodActor) ? "" : vodActor!.trim();
  }

  String getVodContent() {
    return TextUtils.isEmpty(vodContent) ? "" : vodContent!.trim().replaceAll("\n", "<br>");
  }

  String getVodPlayFrom() {
    return TextUtils.isEmpty(vodPlayFrom) ? "" : vodPlayFrom!;
  }

  String getVodPlayUrl() {
    return TextUtils.isEmpty(vodPlayUrl) ? "" : vodPlayUrl!;
  }

  String getVodTag() {
    return TextUtils.isEmpty(vodTag) ? "" : vodTag!;
  }

  Cate? getCate() {
    return j_cate;
  }

  Style? getStyle({Style? style}) {
    if (style != null) return getStyle() != null ? getStyle() : style;
    else return j_style != null ? j_style : Style.get(getLand(), getCircle(), getRatio());
  }

  int getLand() {
    return j_land!;
  }

  int getCircle() {
    return j_circle!;
  }

  double getRatio() {
    return j_ratio!;
  }

  List<Flag> getVodFlags() {
    return j_vodFlags = j_vodFlags == null ? [] : j_vodFlags!;
  }

  void setVodFlags({List<Flag>? vodFlags}) {
    if (vodFlags != null)
      this.j_vodFlags = vodFlags;
    else {
      List<String> playFlags = getVodPlayFrom().split(r"\\$\\$\\$");
      List<String> playUrls = getVodPlayUrl().split(r"\\$\\$\\$");
      for (int i = 0; i < playFlags.length; i++) {
        if (playFlags[i].isEmpty || i >= playUrls.length) continue;
        Flag item = Flag.create(playFlags[i].trim());
        item.createEpisode(playUrls[i]);
        getVodFlags().add(item);
      }
      for (Flag item in getVodFlags()) {
        if (item.getUrls() == null) continue;
        item.createEpisode(item.getUrls()!);
      }
    }
  }

  Site? getSite() {
    return j_site;
  }

  void setSite(Site site) {
    this.j_site = site;
  }

  String getSiteName() {
    return getSite() == null ? "" : getSite()!.getName();
  }

  String getSiteKey() {
    return getSite() == null ? "" : getSite()!.getKey();
  }

  int getSiteVisible() {
    return getSite() == null ? 0 : 1;
  }

  int getYearVisible() {
    return getSite() != null || getVodYear().length < 4 ? 0 : 1;
  }

  int getNameVisible() {
    return getVodName().isEmpty ? 0 : 1;
  }

  int getRemarkVisible() {
    return getVodRemarks().isEmpty ? 0 : 1;
  }

  bool isFolder() {
    return "folder" == getVodTag() || getCate() != null;
  }

  bool isManga() {
    return "manga" == getVodTag();
  }

  void trans() {
    if (Trans.pass()) return;
    this.vodName = Trans.s2t(vodName);
    this.vodArea = Trans.s2t(vodArea);
    this.typeName = Trans.s2t(typeName);
    this.vodRemarks = Trans.s2t(vodRemarks);
    if (vodActor != null) this.vodActor = Sniffer.CLICKER.hasMatch(vodActor!) ? vodActor : Trans.s2t(vodActor);
    if (vodContent != null) this.vodContent = Sniffer.CLICKER.hasMatch(vodContent!) ? vodContent : Trans.s2t(vodContent);
    if (vodDirector != null) this.vodDirector = Sniffer.CLICKER.hasMatch(vodDirector!) ? vodDirector : Trans.s2t(vodDirector);
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Vod)) return false;
    return getVodId() == obj.getVodId();
  }
}
