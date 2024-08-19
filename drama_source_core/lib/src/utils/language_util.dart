/*
 * @Author: jadehh
 * @Date: 2024-08-19 13:08:07
 * @LastEditTime: 2024-08-19 13:12:47
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\utils\language_util.dart
 * 
 */
/*
 * @File     : language_utils.dart
 * @Author   : jade
 * @Date     : 2024/07/15 02:51:45
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'dart:ui';

import 'package:drama_source_core/src/model/setting.dart';
import 'package:get/get.dart';

class LanguageUtil {
  static Locale? getLocale() {
    return getLocaleByLanguage(Setting.getLanguage());
  }

  static Locale? getLocaleByLanguage(int language) {
    Locale? appLocale;
    switch (language) {
      case 0: //跟隨系統
        appLocale = Get.deviceLocale;
        break;
      case 1: //简体中文
        appLocale = const Locale('zh', 'CN');
        break;
      case 2: //English
        appLocale = const Locale('zh', 'HK');
        break;
      case 3: //English
        appLocale = const Locale('en', 'US');
        break;
      default:
        appLocale = Get.deviceLocale;
        break;
    }
    return appLocale;
  }
}
