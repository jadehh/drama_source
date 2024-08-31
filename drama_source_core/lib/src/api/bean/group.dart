/*
 * @File     : group.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午10:52
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/api/bean/channel.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  @JsonKey(name: "channel")
  late List<Channel>? j_channel;

  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "pass")
  late String? j_pass;

  @JsonKey(name: "selected")
  bool? j_selected;

  @JsonKey(name: "position")
  int? j_position;

  @JsonKey(name: "width")
  int? j_width;

  Group({List<Channel>? channel, String? name, bool pass = false, bool selected=false, int position=0, int width = 0}) {
    this.j_channel = channel;
    this.j_name = name;
    this.j_selected = selected;
    this.j_position = position;
    this.j_width = width;
    if (name != null) {
      parse(pass);
    }
    if (name!.isEmpty) {
      setName(Local.nav_vod.tr);
    }
  }

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  static List<Group> arrayFrom(List<Map<String, Object?>> mapList) {
    List<Group> items = [];
    for (var element in mapList) {
      items.add(Group.fromJson(element));
    }
    return items;
  }

  static Group create({String? name, bool? pass}) {
    return Group(name: name, pass: pass!);
  }

  void parse(bool pass) {
    List<String> splits = this.j_name!.split("_");
    setName(splits[0]);
    if (pass || splits.length == 1) return;
    setPass(splits[1]);
  }

  List<Channel> getChannel() {
    return j_channel = j_channel == null ? [] : j_channel!;
  }

  void setChannel(List<Channel> channel) {
    this.j_channel = channel;
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  void setName(String name) {
    this.j_name = name;
  }

  String getPass() {
    return TextUtils.isEmpty(j_pass) ? "" : j_pass!;
  }

  void setPass(String pass) {
    this.j_pass = pass;
  }

  bool isSelected() {
    return j_selected!;
  }

  void setSelected(bool selected) {
    this.j_selected = selected;
  }

  int getPosition() {
    return j_position!;
  }

  void setPosition(int position) {
    this.j_position = position;
  }

  int getWidth() {
    return j_width!;
  }

  void setWidth(int width) {
    this.j_position = width;
  }

  bool isHidden() {
    return !TextUtils.isEmpty(getPass());
  }

  bool isKeep() {
    return getName() == Local.keep.tr;
  }

  bool isEmpty() {
    return getChannel().isEmpty;
  }

  bool skip() {
    return isKeep();
  }

  int find({int? number, String? name, Channel? channel}) {
    return getChannel().lastIndexOf(Channel.create(number: number, name: name, channel: channel)!);
  }

  void add(Channel channel) {
    int index = getChannel().indexOf(channel);
    if (index == -1) getChannel().add(Channel.create(channel: channel)!);
    else getChannel()[index].getUrls().addAll(channel.getUrls());
  }

  Channel cfind(Channel channel) {
    int index = getChannel().indexOf(channel);
    if (index != -1) return getChannel()[index];
    getChannel().add(channel);
    return channel;
  }


  Channel current() {
    return getChannel()[getPosition()].group(this);
  }

  bool equals(Object? obj) {
    if (obj == null) return false;
    if (this == obj) return true;
    if (!(obj is Group)) return false;
    return getName() == (obj.getName()) && getChannel().length == obj.getChannel().length;
  }
}
