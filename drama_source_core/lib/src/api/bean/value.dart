/*
 * @File     : value.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午2:27
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'value.g.dart';

@JsonSerializable()
class Value {
  @JsonKey(name: "n")
  late String? j_n;
  @JsonKey(name: "v")
  late String? j_v;
  @JsonKey(name: "activated")
  late bool? j_activated;

  Value({String? n, String? v, bool activated = false}) {
    if (n != null) this.j_n = Trans.s2t(text: n);
    else this.j_n = n;
    this.j_v = v;
    j_activated = activated;
  }

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  String getN() {
    return TextUtils.isEmpty(j_n) ? "" : j_n!;
  }

  String getV() {
    return TextUtils.isEmpty(j_v) ? "" : j_v!;
  }

  void setV(String v) {
    this.j_v = v;
  }

  bool isActivated() {
    return j_activated!;
  }

  void setActivated({bool? activated, Value? item}) {
    if (activated != null) this.j_activated = activated;
    if (item != null) {
      bool equal = item.equals(this);
      if (j_activated! && equal)
        j_activated = false;
      else
        j_activated = equal;
    }
  }

  void trans() {
    this.j_n = Trans.s2t(text: j_n);
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Value)) return false;
    return getV() == obj.getV();
  }
}
