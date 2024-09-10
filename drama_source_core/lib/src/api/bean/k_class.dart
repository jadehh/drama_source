/*
 * @File     : k_class.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午2:09
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/filter.dart';
import 'package:drama_source_core/src/api/bean/style.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'k_class.g.dart';

@JsonSerializable()
class KClass {
  @JsonKey(name: "type_id")
  late String? j_typeId;

  @JsonKey(name: "type_name")
  late String? j_typeName;

  @JsonKey(name: "type_flag")
  late String? j_typeFlag;

  @JsonKey(name: "filters")
  List<Filter>? j_filters;

  @JsonKey(name: "land")
  int? j_land;

  @JsonKey(name: "circle")
  int? j_circle;

  @JsonKey(name: "ratio")
  double? j_ratio;

  @JsonKey(name: "filter")
  bool? j_filter;

  @JsonKey(name: "activated")
  bool? j_activated;

  KClass({
    String? type_id, String? type_name, String? type_flag, List<Filter>? filters,
    int land = 0, int circle = 0, double ratio = 0, bool filter = false, bool activated = false}) {
    this.j_typeId = type_id;
    this.j_typeName = type_name;
    this.j_typeFlag = type_flag;
    this.j_filters = filters;
    this.j_land = land;
    this.j_circle = circle;
    this.j_ratio = ratio;
    this.j_filter = filter;
    this.j_activated = activated;
  }

  factory KClass.fromJson(Map<String, dynamic> json) => _$KClassFromJson(json);

  Map<String, dynamic> toJson() => _$KClassToJson(this);

  String getTypeId() {
    return TextUtils.isEmpty(j_typeId) ? "" : j_typeId!;
  }

  void setTypeId(String typeId) {
    this.j_typeId = typeId;
  }

  String getTypeName() {
    return TextUtils.isEmpty(j_typeName) ? "" : j_typeName!;
  }

  void setTypeName(String typeName) {
    this.j_typeName = typeName;
  }

  String getTypeFlag() {
    return TextUtils.isEmpty(j_typeFlag) ? "" : j_typeFlag!;
  }

  void setTypeFlag(String typeFlag) {
    this.j_typeFlag = typeFlag;
  }

  List<Filter> getFilters() {
    return j_filters == null ? [] : j_filters!;
  }

  void setFilters(List<Filter>? filters) {
    if (filters == null || filters.isEmpty) return;
    this.j_filters = filters;
    this.setFilter(false);
  }

  int getLand() {
    return j_land!;
  }

  int getCircle() {
    return j_circle!;
  }

  double getRatio() {
    return j_ratio!;
  }

  void setFilter(bool filter) {
    this.j_filter = filter;
  }

  bool getFilter() {
    return j_filter!;
  }

  bool isActivated() {
    return j_activated!;
  }

  void setActivated(bool activated) {
    this.j_activated = activated;
  }

  bool toggleFilter() {
    setFilter(!getFilter());
    return getFilter();
  }

  bool isHome() {
    return "home" == getTypeId();
  }

  void trans() {
    if (Trans.pass()) return;
    this.j_typeName = Trans.s2t(text: j_typeName);
  }

  Style? getStyle() {
    return Style.get(getLand(), getCircle(), getRatio());
  }

  Map<String, String> getExtend(bool change) {
    Map<String, String> extend = {};
    for (Filter filter in getFilters()) {
      if (filter.getInit() != null)
        extend[filter.getKey()] = change ? filter.setActivated(filter.getInit()!) : filter.getInit()!;
    }
    return extend;
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is KClass)) return false;
    return getTypeId() == obj.getTypeId();
  }

  int describeContents() {
    return 0;
  }
}
