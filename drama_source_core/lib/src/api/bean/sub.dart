/*
 * @File     : sub.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午5:08
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:io';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/utils/exo_util.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path;

part 'sub.g.dart';

@JsonSerializable()
class Sub {
  @JsonKey(name: "url")
  late String? j_url;

  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "lang")
  late String? j_lang;

  @JsonKey(name: "format")
  late String? j_format;

  @JsonKey(name: "flag")
  late int? j_flag;

  Sub({String? url, String? name, String? lang, String? format, int flag = 2}) {
    this.j_url = url;
    this.j_name = name;
    this.j_lang = lang;
    this.j_format = format;
    this.j_flag = flag;
  }

  factory Sub.fromJson(Map<String, dynamic> json) => _$SubFromJson(json);

  Map<String, dynamic> toJson() => _$SubToJson(this);

  static Future<Sub> from(String path) async {
    if (path.startsWith("http")) {
      return _http(path);
    } else {
      return _file(await Path.utf8(await Path.local(path)));
    }
  }

  static Sub _http(String url) {
    Uri uri = Uri.parse(url);
    Sub sub = new Sub();
    sub.j_url = url;
    sub.j_name = uri.pathSegments.last;
    sub.j_flag = 2;
    sub.j_format = ExoUtil.getMimeType(uri.pathSegments.last);
    return sub;
  }

  static Sub _file(File file) {
    Sub sub = new Sub();
    sub.j_name = path.basename(file.path);
    sub.j_url = file.absolute.path;
    sub.j_flag = 2;
    sub.j_format = ExoUtil.getMimeType(path.basename(file.path));
    return sub;
  }

  String getUrl() {
    return TextUtils.isEmpty(j_url) ? "" : j_url!;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  String getLang() {
    return TextUtils.isEmpty(j_lang) ? "" : j_lang!;
  }

  String getFormat() {
    return TextUtils.isEmpty(j_format) ? "" : j_format!;
  }

  int getFlag() {
    return j_flag == 0 ? 2 : j_flag!;
  }

  void trans() {
    if (Trans.pass()) return;
    this.j_name = Trans.s2t(j_name);
  }

  //  MediaItem.SubtitleConfiguration getConfig() {
  //     return new MediaItem.SubtitleConfiguration.Builder(Uri.parse(getUrl())).setLabel(getName()).setMimeType(getFormat()).setSelectionFlags(getFlag()).setLanguage(getLang()).build();
  // }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Sub)) return false;
    return getUrl() == obj.getUrl();
  }
}
