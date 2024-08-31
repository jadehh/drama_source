/*
 * @Author: jadehh
 * @Date: 2024-08-19 13:09:33
 * @LastEditTime: 2024-08-21 17:35:24
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\model\language\message.dart
 * 
 */
import 'package:cat_vod/src/model/language/local.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          Local.doh_name: Local.doh_name,
          Local.doh_url: Local.doh_url,
        },
        'zh_HK': {
          Local.doh_name: "系統,騰訊,阿里,360",
          Local.doh_url: Local.doh_url,
        },
        'en_US': {
          Local.doh_name: "System,Tencent,Alibaba,360",
          Local.doh_url: Local.doh_url,
        },
      };
}
