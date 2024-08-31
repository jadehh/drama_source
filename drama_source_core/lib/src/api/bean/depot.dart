/*
 * @File     : depot.dart
 * @Author   : jade
 * @Date     : 2024/8/22 下午3:55
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'depot.g.dart';

@JsonSerializable()
class Depot {
  @JsonKey(name: "url")
  late String? j_url;
  @JsonKey(name: "name")
  late String? j_name;

  Depot({String? url,String? name}){
    this.j_url = url;
    this.j_name = name;
  }

  factory Depot.fromJson(Map<String, dynamic> json) => _$DepotFromJson(json);
  Map<String, dynamic> toJson() => _$DepotToJson(this);

  static List<Depot> arrayFrom(List<Map<String, Object?>> mapList) {
    List<Depot> items = [];
    for (var element in mapList) {
      items.add(Depot.fromJson(element));
    }
    return items;
  }

  String getUrl() {
        return TextUtils.isEmpty(j_url) ? "" : UrlUtil.fixUrl(j_url!);
    }

     String getName() {
        return TextUtils.isEmpty(j_name) ? getUrl() : j_name!;
    }
}
