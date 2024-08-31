/*
 * @File     : epg_data.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午9:43
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/src/model/language/local.dart';
import 'package:sprintf/sprintf.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'epg_data.g.dart';

@JsonSerializable()
class EpgData {
  @JsonKey(name: "title")
  late String? j_title;

  @JsonKey(name: "start")
  late String? j_start;

  @JsonKey(name: "end")
  late String? j_end;

  @JsonKey(name: "selected")
  late bool? j_selected;

  @JsonKey(name: "startTime")
  late int? j_startTime;

  @JsonKey(name: "endTime")
  late int? j_endTime;

  EpgData({String? title,String? start,String? end,bool selected = false,int startTime = 0,int endTime = 0}){
    this.j_title = title;
    this.j_start = start;
    this.j_end = end;
    this.j_selected = selected;
    this.j_startTime = startTime;
    this.j_endTime = endTime;
  }

  factory EpgData.fromJson(Map<String, dynamic> json) => _$EpgDataFromJson(json);

  Map<String, dynamic> toJson() => _$EpgDataToJson(this);

  String getTitle() {
    return TextUtils.isEmpty(j_title) ? "" : j_title!;
  }

  void setTitle(String title) {
    this.j_title = title;
  }

  String getStart() {
    return TextUtils.isEmpty(j_start) ? "" : j_start!;
  }

  void setStart(String start) {
    this.j_start = start;
  }

  String getEnd() {
    return TextUtils.isEmpty(j_end) ? "" : j_end!;
  }

  void setEnd(String end) {
    this.j_end = end;
  }

  bool isSelected() {
    return j_selected!;
  }

  void setSelected({bool? selected, EpgData? item}) {
    if (selected != null) this.j_selected = selected;
    if (item != null) this.j_selected = item.equals(this);
  }

  int getStartTime() {
    return j_startTime!;
  }

  void setStartTime(int startTime) {
    this.j_startTime = startTime;
  }

  int getEndTime() {
    return j_endTime!;
  }

  void setEndTime(int endTime) {
    this.j_endTime = endTime;
  }

  bool isInRange() {
    return getStartTime() <= DateTime.now().millisecondsSinceEpoch && DateTime.now().millisecondsSinceEpoch <= getEndTime();
  }

  bool isFuture() {
    return getStartTime() > DateTime.now().millisecondsSinceEpoch;
  }

  String format({String? group}) {
    if (group != null) {
      // String pattern = group.split("\\)")[1].split("\\}")[0];
      // if (group.contains("(b)"))
      //   return new SimpleDateFormat(pattern, Locale.getDefault()).format(getStartTime());
      // if (group.contains("(e)"))
      //   return new SimpleDateFormat(pattern, Locale.getDefault()).format(getEndTime());
      return "";
    } else {
      if (getTitle().isEmpty) return "";
      if (getStart().isEmpty && getEnd().isEmpty)
        return sprintf(Local.play_now, getTitle());
      return getStart() + " ~ " + getEnd() + "  " + getTitle();
    }
  }

  String getTime() {
    if (getStart().isEmpty && getEnd().isEmpty) return "";
    return getStart() + "~" + getEnd();
  }

  equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is EpgData)) return false;
    return getTitle() == (obj.getTitle()) && getEnd() == (obj.getEnd()) && getStart() == (obj.getStart());
  }
}
