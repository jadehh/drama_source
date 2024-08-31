/*
 * @File     : catch_up.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午10:27
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/src/api/bean/epg_data.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catch_up.g.dart';

@JsonSerializable()
class Catchup {
  @JsonKey(name: "type")
  late String? j_type;
  @JsonKey(name: "days")
  late String? j_days;
  @JsonKey(name: "regex")
  late String? j_regex;
  @JsonKey(name: "source")
  late String? j_source;

  Catchup({String? type, String? days, String? regex, String? source}) {
    this.j_type = type;
    this.j_days = days;
    this.j_regex = regex;
    this.j_source = source;
  }
  factory Catchup.fromJson(Map<String, dynamic> json) => _$CatchupFromJson(json);

  Map<String, dynamic> toJson() => _$CatchupToJson(this);


  static Catchup PLTV() {
    Catchup item = new Catchup();
    item.setDays("7");
    item.setType("append");
    item.setRegex("/PLTV/");
    item.setSource(r"?playseek=${(b)yyyyMMddHHmmss}-${(e)yyyyMMddHHmmss}");
    return item;
  }

  static Catchup create() {
    return Catchup();
  }

  static Catchup? decide(Catchup major, Catchup minor) {
    if (!major.isEmpty()) return major;
    if (!minor.isEmpty()) return minor;
    return null;
  }

  String getType() {
    return TextUtils.isEmpty(j_type) ? "" : j_type!;
  }

  void setType(String type) {
    this.j_type = type;
  }

  String getDays() {
    return TextUtils.isEmpty(j_days) ? "" : j_days!;
  }

  void setDays(String days) {
    this.j_days = days;
  }

  String getRegex() {
    return TextUtils.isEmpty(j_regex) ? "" : j_regex!;
  }

  void setRegex(String regex) {
    this.j_regex = regex;
  }

  String getSource() {
    return TextUtils.isEmpty(j_source) ? "" : j_source!;
  }

  void setSource(String source) {
    this.j_source = source;
  }

  bool match(String url) {
    return url.contains(getRegex()) || RegExp(getRegex()).allMatches(url).length > 0;
  }

  bool isEmpty() {
    return getSource().isEmpty;
  }

  bool isAppend() {
    return getType() == "append";
  }

  bool isDefault() {
    return getType() == "default";
  }

  String format(String url, {String? result, EpgData? data}) {
    if (result != null) {
      if (!TextUtils.isEmpty(Uri.parse(url).query)) result = result.replaceAll("?", "&");
      if (url.contains("/PLTV/")) url = url.replaceAll("/PLTV/", "/TVOD/");
      return url + result;
    }
    if (data != null) {
      String result = getSource();
      if (data.isInRange()) return url;
      final RegExp regExp = RegExp(r"(\\$\\{[^}]*\\})");
      Iterable<RegExpMatch> matches = regExp.allMatches(result);
      for (var matcher in matches) {
        result = result.replaceAll(matcher.group(1)!, data.format(group: matcher.group(1)));
      }
      return isDefault() ? result : format(url, result: result);
    }
    return "";
  }
}
