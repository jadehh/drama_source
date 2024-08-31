/*
 * @Author: jadehh
 * @Date: 2024-08-22 09:24:30
 * @LastEditTime: 2024-08-22 09:24:33
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\bean\rule.dart
 * 
 */
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rule.g.dart';

@JsonSerializable()
class Rule {
  @JsonKey(name: "name", required: true)
  late String? j_name;

  @JsonKey(name: "hosts")
  late List<String>? j_hosts;

  @JsonKey(name: "regex")
  late List<String>? j_regex;

  @JsonKey(name: "script")
  late List<String>? j_script;

  @JsonKey(name: "exclude")
  late List<String>? j_exclude;

  Rule({String? name, List<String>?hosts,List<String>?regex, List<String>? script, List<String>? exclued}) {
    this.j_name = name;
    this.j_hosts = hosts;
    this.j_regex = regex;
    this.j_script = script;
    this.j_exclude = exclued;
  }

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);

  Map<String, dynamic> toJson() => _$RuleToJson(this);

  static Rule create(String name) {
    return Rule(name: name);
  }

  static Rule empty() {
    return Rule(name: "");
  }

  static List<Rule> arrayFrom(List<dynamic> mapList) {
    List<Rule> items = [];
    for (var element in mapList) {
      items.add(Rule.fromJson(element));
    }
    return items;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  List<String> getHosts() {
    return j_hosts == null ? [] : j_hosts!;
  }

  List<String> getRegex() {
    return j_regex == null ? [] : j_regex!;
  }

  List<String> getScript() {
    return j_script == null ? [] : j_script!;
  }

  List<String> getExclude() {
    return j_exclude == null ? [] : j_exclude!;
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Rule)) return false;
    return getName() == (obj.getName());
  }
}
