/*
 * @File     : doh.dart
 * @Author   : jade
 * @Date     : 2024/08/22 09:10:49
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'dart:io';

import 'package:cat_vod/src/model/language/local.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:drama_source_log/drama_source_log.dart';

part 'doh.g.dart';

@JsonSerializable()
class Doh {
  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "url")
  late String? j_url;

  @JsonKey(name: "ips")
  late List<String>? j_ips;

  Doh() {}

  factory Doh.fromJson(Map<String, dynamic> json) => _$DohFromJson(json);

  Map<String, dynamic> toJson() => _$DohToJson(this);

  static List<Doh> get() {
    List<Doh> items = [];
    List<String> urls = Local.doh_url.split(",");
    List<String> names = Local.doh_name.split(",");
    for (int i = 0; i < names.length; i++)
      items.add(new Doh().name(names[i]).url(urls[i]));
    return items;
  }

  static List<Doh> arrayFrom(List<dynamic> mapList) {
    List<Doh> items = [];
    for (var element in mapList) {
      items.add(Doh.fromJson(element));
    }
    return items;
  }

  Doh name(String name) {
    this.j_name = name;
    return this;
  }

  Doh url(String url) {
    this.j_url = url;
    return this;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  String getUrl() {
    return TextUtils.isEmpty(j_url) ? "" : j_url!;
  }

  List<String> getIps() {
    return j_ips == null ? [] : j_ips!;
  }

  List<InternetAddress>? getHosts() {
    try {
      List<InternetAddress> list = [];
      for (String ip in getIps()) {
        list.add(InternetAddress(ip));
      }
      return list.isEmpty ? null : list;
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return null;
    }
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Doh)) return false;
    return getUrl() == obj.getUrl();
  }
}
