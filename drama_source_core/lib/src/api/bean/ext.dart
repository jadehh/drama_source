/*
 * @File     : ext.dart
 * @Author   : jade
 * @Date     : 2024/08/22 09:34:59
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:json_annotation/json_annotation.dart';

part 'ext.g.dart';

@JsonSerializable()
class Ext {
  @JsonKey(name: "flag")
  late List<String>? j_flag;
  @JsonKey(name: "header")
  late Map<String, dynamic>? j_header;

  Ext({List<String>? flag, Map<String, dynamic>? header}) {
    this.j_flag = flag;
    this.j_header = header;
  }

  factory Ext.fromJson(Map<String, dynamic> json) => _$ExtFromJson(json);

  Map<String, dynamic> toJson() => _$ExtToJson(this);

  void setFlag(List<String> flag) {
    this.j_flag = flag;
  }

  List<String> getFlag() {
    return j_flag == null ? [] : j_flag!;
  }

  Map<String, dynamic>? getHeader() {
    return j_header;
  }

  void setHeader(Map<String, String> header) {
    this.j_header = header;
  }

  bool isEmpty() {
    return j_flag == null && j_header == null;
  }
}
