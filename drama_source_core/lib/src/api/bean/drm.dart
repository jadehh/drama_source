/*
 * @File     : drm.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午10:44
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/service/sync_service.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drm.g.dart';

@JsonSerializable()
class Drm {
  @JsonKey(name: "key")
  late String? j_key;
  @JsonKey(name: "type")
  late String? j_type;

  Drm({String? key, String? type}) {
    this.j_key = key;
    this.j_type = type;
  }

  factory Drm.fromJson(Map<String, dynamic> json) => _$DrmFromJson(json);

  Map<String, dynamic> toJson() => _$DrmToJson(this);

  static Drm create(String key, String type) {
    return new Drm(key: key, type: type);
  }

  String getKey() {
    return TextUtils.isEmpty(j_key) ? "" : j_key!;
  }

  String getType() {
    return TextUtils.isEmpty(j_type) ? "" : j_type!;
  }

  // UUID getUUID() {
  //   if (getType().contains("playready")) return C.PLAYREADY_UUID;
  //   if (getType().contains("widevine")) return C.WIDEVINE_UUID;
  //   if (getType().contains("clearkey")) return C.CLEARKEY_UUID;
  //   return C.UUID_NIL;
  // }

  Future<String> getUri() async {
    if (getKey().startsWith("http")) return getKey();
    return await SyncService.get().getAddressByPath("license") + Util.base64ToStr(s: getKey());
  }

  // MediaItem.DrmConfiguration get() {
  //   return new MediaItem.DrmConfiguration.Builder(getUUID()).setLicenseUri(getUri()).build();
  // }
}
