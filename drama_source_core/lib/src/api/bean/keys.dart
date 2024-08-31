/*
 * @File     : keys.dart
 * @Author   : jade
 * @Date     : 2024/8/28 下午2:15
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:json_annotation/json_annotation.dart';

part 'keys.g.dart';

@JsonSerializable()
class Keys {

  @JsonKey(name: "kty")
  late String? j_kty;
  @JsonKey(name: "k")
  late String? j_k;
  @JsonKey(name: "kid")
  late String? j_kid;

  Keys({String? kid, String? k}) {
    this.j_kty = "oct";
    this.j_kid = kid;
    this.j_k = k;
  }
  factory Keys.fromJson(Map<String, dynamic> json) => _$KeysFromJson(json);

  Map<String, dynamic> toJson() => _$KeysToJson(this);

}

