/*
 * @File     : filter.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午2:22
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/value.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

@JsonSerializable()
class Filter {
  @JsonKey(name: "key")
  late String? j_key;

  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "init")
  late String? j_init;

  @JsonKey(name: "value")
  late List<Value>? j_value;

  Filter({String? key, String? name, String? init, List<Value>? value}) {
    this.j_key = key;
    this.j_name = name;
    this.j_init = init;
    this.j_value = value;
  }

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);

  String getKey() {
    return TextUtils.isEmpty(j_key) ? "" : j_key!;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  String? getInit() {
    return j_init;
  }

  List<Value> getValue() {
    return j_value == null ? [] : j_value!;
  }

  String setActivated(String v) {
    int index = getValue().indexOf(Value(v: v));
    if (index != -1) getValue()[index].setActivated(activated: true);
    return v;
  }

  Filter check() {
    // Iterables.removeIf(getValue(), Predicates.isNull());
    return this;
  }

  Filter trans() {
    if (Trans.pass()) return this;
    for (Value value in getValue()) value.trans();
    return this;
  }
}
