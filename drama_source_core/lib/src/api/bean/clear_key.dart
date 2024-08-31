/*
 * @File     : clear_key.dart
 * @Author   : jade
 * @Date     : 2024/8/28 下午2:14
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clear_key.g.dart';

@JsonSerializable()
class ClearKey {

  @JsonKey(name: "keys")
  late List<Keys>? j_keys;
  @JsonKey(name: "type")
  late String? j_type;


  ClearKey({String? type}){
    j_type = type;
  }

  static ClearKey get(String line) {
    ClearKey item =  ClearKey();
    item.j_keys = [];
    item.j_type = "temporary";
    item.addKeys(line);
    return item;
  }

  factory ClearKey.fromJson(Map<String, dynamic> json) => _$ClearKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ClearKeyToJson(this);

  void addKeys(String line) {
    for (String s in line.split(",")) {
    List <String> a = s.split(":");
    String kid = Util.base64ToStr(s:a[0]).replaceAll("=", "");
    String k = Util.base64ToStr(s:a[1]).replaceAll("=", "");
    j_keys!.add(new Keys(kid: kid, k: k));
    }
  }
}
