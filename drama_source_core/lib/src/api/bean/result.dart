/*
 * @File     : result.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午1:59
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/drm.dart';
import 'package:drama_source_core/src/api/bean/filter.dart';
import 'package:drama_source_core/src/api/bean/k_class.dart';
import 'package:drama_source_core/src/api/bean/style.dart';
import 'package:drama_source_core/src/api/bean/sub.dart';
import 'package:drama_source_core/src/api/bean/url.dart';
import 'package:drama_source_core/src/api/bean/vod.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  @JsonKey(name: "types")
  late List<KClass>? j_types;

  @JsonKey(name: "list")
  late List<Vod>? j_list;

  @JsonKey(name: "filters")
  late Map<String, List<Filter>>? j_filters;

  @JsonKey(name: "url")
  late Url? j_url;

  @JsonKey(name: "msg")
  late String? j_msg;

  @JsonKey(name: "subs")
  late List<Sub>? j_subs;

  @JsonKey(name: "header")
  late Map<String, dynamic>? j_header;

  @JsonKey(name: "playUrl")
  late String? j_playUrl;

  @JsonKey(name: "jxFrom")
  late String? j_jxFrom;

  @JsonKey(name: "flag")
  late String? j_flag;

  @JsonKey(name: "danmaku")
  late String? j_danmaku;

  @JsonKey(name: "format")
  late String? j_format;

  @JsonKey(name: "click")
  late String? j_click;

  @JsonKey(name: "js")
  late String? j_js;

  @JsonKey(name: "key")
  late String? j_key;

  @JsonKey(name: "pagecount")
  late int? j_pagecount;

  @JsonKey(name: "parse")
  late int? j_parse;

  @JsonKey(name: "code")
  late int? j_code;

  @JsonKey(name: "jx")
  late int? j_jx;

  @JsonKey(name: "drm")
  late Drm? j_drm;

  Result(
      {String? msg,
      String? playUrl,
      String? jxFrom,
      String? flag,
      String? danmaku,
      String? format,
      String? click,
      String? js,
      String? key,
      int? pagecount,
      int? parse,
      int? code,
      int? jx}) {
    this.j_types = [];
    this.j_list = [];
    this.j_filters = {};
    this.j_url = null;
    this.j_msg = msg;
    this.j_subs = [];
    this.j_header = {};
    this.j_playUrl = playUrl;
    this.j_jxFrom = jxFrom;
    this.j_flag = flag;
    this.j_danmaku = danmaku;
    this.j_click = click;
    this.j_js = js;
    this.j_key = key;
    this.j_pagecount = pagecount;
    this.j_parse = parse;
    this.j_code = code;
    this.j_jx = jx;
    this.j_drm = null;
  }

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  static Result fromXml(String str) {
    try {
      // XmlDocument()
      //   return new Persister().read(Result.class, str, false).trans();
      Log.w("Result fromXml 方法还未实现");
      return empty();
    } catch (e) {
      return empty();
    }
  }

  static Result fromType(int type, String str) {
    return type == 0 ? fromXml(str) : Result.fromJson(Json.parse(str));
  }

  static Result empty() {
    return new Result();
  }

  static Result error(String msg) {
    Result result = new Result();
    result.setMsg(msg);
    return result;
  }

  static Result folder(Vod item) {
    Result result = new Result();
    KClass type = new KClass();
    type.setTypeFlag("1");
    type.setTypeId(item.getVodId());
    type.setTypeName(item.getVodName());
    result.setTypes([type]);
    return result;
  }

  static Result type(String json) {
    Result result = new Result();
    result.setTypes([KClass.fromJson(Json.parse(json))]);
    return result.trans();
  }

  static Result list(List<Vod> items) {
    Result result = Result();
    result.setList(items);
    return result;
  }

  static Result vod(Vod item) {
    return list([item]);
  }

  List<KClass> getTypes() {
    return j_types == null ? [] : j_types!;
  }

  void setTypes(List<KClass> types) {
    if (types.length > 0) this.j_types = types;
  }

  List<Vod> getList() {
    return j_list == null ? [] : j_list!;
  }

  void setList(List<Vod> list) {
    this.j_list = list;
  }

  Map<String, List<Filter>> getFilters() {
    return j_filters == null ? {} : j_filters!;
  }

  Url getUrl() {
    return j_url == null ? Url.create() : j_url!;
  }

  void setUrl({Url? url, String? urlStr}) {
    if (url != null) this.j_url = url;
    if (urlStr != null) this.j_url = getUrl().replace(urlStr);
  }

  String getMsg() {
    return TextUtils.isEmpty(j_msg) || getCode() != 0 ? "" : j_msg!;
  }

  void setMsg(String msg) {
    this.j_msg = msg;
  }

  List<Sub> getSubs() {
    return j_subs == null ? [] : j_subs!;
  }

  Map<String, dynamic>? getHeader() {
    return j_header;
  }

  void setHeader(Map<String, dynamic> header) {
    if (getHeader() == null) this.j_header = header;
  }

  String getPlayUrl() {
    return TextUtils.isEmpty(j_playUrl) ? "" : j_playUrl!;
  }

  void setPlayUrl(String playUrl) {
    this.j_playUrl = playUrl;
  }

  String getJxFrom() {
    return TextUtils.isEmpty(j_jxFrom) ? "" : j_jxFrom!;
  }

  String getFlag() {
    return TextUtils.isEmpty(j_flag) ? "" : j_flag!;
  }

  void setFlag(String flag) {
    this.j_flag = flag;
  }

  String getDanmaku() {
    return TextUtils.isEmpty(j_danmaku) ? "" : j_danmaku!;
  }

  void setDanmaku(String danmaku) {
    this.j_danmaku = danmaku;
  }

  String? getFormat() {
    return j_format;
  }

  String getClick() {
    return TextUtils.isEmpty(j_click) ? "" : j_click!;
  }

  void setClick(String click) {
    this.j_click = click;
  }

  String getJs() {
    return TextUtils.isEmpty(j_js) ? "" : j_js!;
  }

  void setJs(String js) {
    this.j_js = js;
  }

  String getKey() {
    return TextUtils.isEmpty(j_key) ? "" : j_key!;
  }

  void setKey(String key) {
    this.j_key = key;
  }

  int getPageCount() {
    return this.j_pagecount == null ? 0 : this.j_pagecount!;
  }

  int getParse({int? def}) {
    if (def != null)
      return this.j_parse == null ? def : j_parse!;
    else
      return getParse(def: 0);
  }

  void setParse(int parse) {
    this.j_parse = parse;
  }

  int getCode() {
    return this.j_code == null ? 0 : this.j_code!;
  }

  int getJx() {
    return this.j_jx == null ? 0 : this.j_jx!;
  }

  Drm? getDrm() {
    return j_drm;
  }

  bool hasMsg() {
    return getMsg().length > 0;
  }

  String getRealUrl() {
    return getPlayUrl() + getUrl().v();
  }

  Map<String, String> getHeaders() {
    return Json.toMap(json: getHeader());
  }

  Style getStyle(Style style) {
    return getList().isEmpty ? Style.rect() : getList()[0].getStyle(style: style)!;
  }

  Result clear() {
    getList().clear();
    return this;
  }

  Result trans() {
    if (Trans.pass()) return this;
    for (KClass type in getTypes()) type.trans();
    for (Vod vod in getList()) vod.trans();
    for (Sub sub in getSubs()) sub.trans();
    return this;
  }
}
