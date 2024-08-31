/*
 * @File     : core.dart
 * @Author   : jade
 * @Date     : 2024/8/28 上午9:41
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/src/utils/url_util.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';

part 'core.g.dart';
@JsonSerializable()
class Core {
  @JsonKey(name: "auth")
  late String? j_auth;

  @JsonKey(name: "name")
  late String? j_name;

  @JsonKey(name: "pass")
  late String? j_pass;

  @JsonKey(name: "broker")
  late String? j_broker;

  @JsonKey(name: "resp")
  late String? j_resp;

  @JsonKey(name: "sign")
  late String? j_sign;

  @JsonKey(name: "pkg")
  late String? j_pkg;

  @JsonKey(name: "so")
  late String? j_so;

  Core({String? auth,String? name,String? pass,String? broker,String? resp,String? sign,String? pkg,String? so}){
    this.j_auth = auth;
    this.j_name = name;
    this.j_pass = pass;
    this.j_broker = broker;
    this.j_resp = resp;
    this.j_sign = sign;
    this.j_pkg = pkg;
    this.j_so = so;
}

  factory Core.fromJson(Map<String, dynamic> json) => _$CoreFromJson(json);

  Map<String, dynamic> toJson() => _$CoreToJson(this);

  Future<String> getAuth() async {
    return TextUtils.isEmpty(j_auth) ? "" : await UrlUtil.convert(j_auth!);
  }

  String getName() {
    return TextUtils.isEmpty(j_name) ? "" : j_name!;
  }

  String getPass() {
    return TextUtils.isEmpty(j_pass) ? "" : j_pass!;
  }

  String getBroker() {
    return TextUtils.isEmpty(j_broker) ? "" : j_broker!;
  }

  String getResp() {
    return TextUtils.isEmpty(j_resp) ? "" : j_resp!;
  }

  String getSign() {
    return TextUtils.isEmpty(j_sign) ? "" : j_sign!;
  }

  String getPkg() {
    return TextUtils.isEmpty(j_pkg) ? "" : j_pkg!;
  }

  String getSo() {
    return TextUtils.isEmpty(j_so) ? "" : j_so!;
  }

  bool hook() {
    return getPkg().length > 0 && getSign().length > 0;
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Core)) return false;
    return getSo() == obj.getSo();
  }
}
