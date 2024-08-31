/*
 * @File     : url.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午5:00
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:math';

import 'package:drama_source_core/src/api/bean/value.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'url.g.dart';

@JsonSerializable()
class Url {
  @JsonKey(name: "values")
  late List<Value>? j_values;

  @JsonKey(name: "position")
  late int? j_position;

  Url({int position = 0}) {
    j_values = [];
    j_position = position;
  }
  factory Url.fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);

  Map<String, dynamic> toJson() => _$UrlToJson(this);

  static Url create() {
    return  Url();
  }

  List<Value> getValues() {
    return j_values = j_values == null ? [] : j_values!;
  }

  int getPosition() {
    return j_position!;
  }

  String v({int? position}) {
    if (position != null) return position >= getValues().length ? "" : getValues()[position].getV();
    else return v(position: getPosition());
  }

  String n(int position) {
    return position >= getValues().length ? "" : getValues()[position].getN();
  }

  Url add({String? n, String? v}) {
    getValues().add(new Value(n: n, v: v));
    return this;
  }

  Url replace(String url) {
    getValues()[getPosition()].setV(url);
    return this;
  }

  Url set(int position) {
    this.j_position = min(position, getValues().length - 1);
    return this;
  }

  bool isEmpty() {
    return getValues().isEmpty || TextUtils.isEmpty(v());
  }

  bool isMulti() {
    return getValues().length > 1;
  }
}
