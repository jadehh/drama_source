/*
 * @Author: jadehh
 * @Date: 2024-08-21 14:24:09
 * @LastEditTime: 2024-08-21 15:28:52
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\bean\style.dart
 * 
 */
import 'dart:math';

import 'package:drama_source_core/src/ui/base/view_type.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'style.g.dart';

@JsonSerializable()
class Style {
  @JsonKey(name: "type")
  late  String? j_type;

  @JsonKey(name: "ratio")
  late  double? j_ratio;

  Style({String? type, double? ratio}) {
    this.j_type = type;
    this.j_ratio = ratio;
  }

  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);

  Map<String, dynamic> toJson() => _$StyleToJson(this);

  static Style rect() {
    return Style(type: "rect", ratio: 0.75);
  }

  static Style list() {
    return Style(type: "list");
  }

  static Style? get(int land, int circle, double ratio) {
    if (land == 1)
      return new Style(type: "rect", ratio: ratio == 0 ? 1.33 : ratio);
    if (circle == 1)
      return new Style(type: "oval", ratio: ratio == 0 ? 1.0 : ratio);
    return null;
  }

  String getType() {
    return TextUtils.isEmpty(j_type) ? "rect" : j_type!;
  }

  double getRatio() {
    return j_ratio! <= 0 ? (isOval() ? 1.0 : 0.75) : min(4, j_ratio!);
  }

  isRect() {
    return "rect" == getType();
  }

  bool isOval() {
    return "oval" == getType();
  }

  bool isList() {
    return "list" == getType();
  }

  bool isLand() {
    return isRect() && getRatio() > 1.0;
  }

  int getViewType() {
    switch (getType()) {
      case "oval":
        return ViewType.OVAL;
      case "list":
        return ViewType.LIST;
      default:
        return ViewType.RECT;
    }
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Style)) return false;
    return getType() == (obj.getType()) && getRatio() == obj.getRatio();
  }
}
