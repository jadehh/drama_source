/*
 * @File     : epg.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午9:37
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/src/api/bean/epg_data.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'epg.g.dart';

@JsonSerializable()
class Epg {
  @JsonKey(name: "key")
  late String? j_key;

  @JsonKey(name: "date")
  late String? j_date;

  @JsonKey(name: "epg_data")
  late List<EpgData>? j_list;

  @JsonKey(name: "width")
  late int? j_width;

  Epg({String? key, String? date, List<EpgData>? list, int? width}) {
    this.j_key = key;
    this.j_date = date;
    this.j_list = list;
    this.j_width = width;
  }

  factory Epg.fromJson(Map<String, dynamic> json) => _$EpgFromJson(json);

  Map<String, dynamic> toJson() => _$EpgToJson(this);

  static Epg create(String key, String date) {
    Epg item = new Epg();
    item.setKey(key);
    item.setDate(date);
    item.setList([]);
    return item;
  }

  String getKey() {
    return TextUtils.isEmpty(j_key) ? "" : j_key!;
  }

  void setKey(String key) {
    this.j_key = key;
  }

  String getDate() {
    return TextUtils.isEmpty(j_date) ? "" : j_date!;
  }

  void setDate(String date) {
    this.j_date = date;
  }

  List<EpgData> getList() {
    return j_list == null ? [] : j_list!;
  }

  void setList(List<EpgData> list) {
    this.j_list = list;
  }

  int getWidth() {
    return j_width!;
  }

  void setWidth(int width) {
    this.j_width = width;
  }

  bool equal(String date) {
    return getDate() == date;
  }

  //  void setTime(SimpleDateFormat format) {
  //     setList(new ArrayList<>(new LinkedHashSet<>(getList())));
  //     for (EpgData item : getList()) {
  //         item.setStartTime(Util.format(format, getDate().concat(item.getStart())));
  //         item.setEndTime(Util.format(format, getDate().concat(item.getEnd())));
  //         item.setTitle(Trans.s2t(item.getTitle()));
  //     }
  // }

  String getEpg() {
    for (EpgData item in getList()) if (item.isSelected()) return item.format();
    return "";
  }

  Epg selected() {
    for (EpgData item in getList()) item.setSelected(selected: item.isInRange());
    return this;
  }

  int getSelected() {
    for (int i = 0; i < getList().length; i++){
      if (getList()[i].isSelected()) return i;
    }
    return -1;
  }

  int getInRange() {
    for (int i = 0; i < getList().length; i++) {
      if (getList()[i].isInRange()) return i;
    }
    return -1;
  }
}
