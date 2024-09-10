/*
 * @File     : episode.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午3:58
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:cat_vod/cat_vod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "desc")
  late String? j_desc;

  @JsonKey(name: "url")
  late String? j_url;

  @JsonKey(name: "index")
  late int? j_index;

  @JsonKey(name: "number")
  late int? j_number;

  @JsonKey(name: "activated")
  late bool? j_activated;

  @JsonKey(name: "selected")
  late bool? j_selected;

  Episode({String? name, String? desc, String? url, int index = 0, bool activated = false, bool selected = false}) {
    this.j_name = Trans.s2t(text:name);
    this.j_desc = Trans.s2t(text: name);
    this.j_number = Util.getDigit(name);
    this.j_url = url;
    this.j_index = index;
    this.j_activated = activated;
    this.j_selected = selected;
  }

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);


  static Episode create({String? name, String? des, String? url}) {
    return new Episode(name: name, desc: des, url: url);
  }

  String getName() {
    return j_name!;
  }

  void setName(String name) {
    this.j_name = name;
  }

  String getDesc() {
    return j_desc!;
  }

  String getUrl() {
    return j_url!;
  }

  int getIndex() {
    return j_index!;
  }

  void setIndex(int index) {
    this.j_index = index;
  }

  int getNumber() {
    return j_number!;
  }

  bool isActivated() {
    return j_activated!;
  }

  void setActivated(bool activated) {
    this.j_activated = activated;
    this.j_selected = activated;
  }

  void deactivated() {
    setActivated(false);
  }

  bool isSelected() {
    return j_selected!;
  }

  void setSelected(bool selected) {
    this.j_selected = selected;
  }

  bool rule1(String name) {
    return getName().toLowerCase == name.toLowerCase();
  }

  bool rule2(int number) {
    return getNumber() == number && number != -1;
  }

  bool rule3(String name) {
    return getName().toLowerCase().contains(name.toLowerCase());
  }

  bool rule4(String name) {
    return name.toLowerCase().contains(getName().toLowerCase());
  }

  bool equals({Episode? episode, Object? obj}) {
    if (episode != null) return rule1(episode.getName());
    if (obj != null) {
      if (this == obj) return true;
      if (!(obj is Episode)) return false;
      return getUrl() == obj.getUrl() && getName() == obj.getName();
    }
    return false;
  }
}
