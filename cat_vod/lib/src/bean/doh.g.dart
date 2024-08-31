// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doh _$DohFromJson(Map<String, dynamic> json) => Doh()
  ..j_name = json['name'] as String?
  ..j_url = json['url'] as String?
  ..j_ips = (json['ips'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$DohToJson(Doh instance) => <String, dynamic>{
      'name': instance.j_name,
      'url': instance.j_url,
      'ips': instance.j_ips,
    };
