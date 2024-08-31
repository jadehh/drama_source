/*
 * @File     : cate.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午3:43
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/src/api/bean/style.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cate.g.dart';

@JsonSerializable()
class Cate {
  @JsonKey(name: "land")
  late int? j_land;

  @JsonKey(name: "circle")
  late int? j_circle;

  @JsonKey(name: "ratio")
  late double? j_ratio;

  Cate({int land = 0, int circle = 0, double ratio = 0}) {
    this.j_land = land;
    this.j_circle = circle;
    this.j_ratio = ratio;
  }

  factory Cate.fromJson(Map<String, dynamic> json) => _$CateFromJson(json);

  Map<String, dynamic> toJson() => _$CateToJson(this);

  int getLand() {
    return j_land!;
  }

  int getCircle() {
    return j_circle!;
  }

  double getRatio() {
    return j_ratio!;
  }

  Style? getStyle() {
    return Style.get(getLand(), getCircle(), getRatio());
  }
}
