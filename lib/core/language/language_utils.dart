/*
 * @File     : language_utils.dart
 * @Author   : jade
 * @Date     : 2024/07/15 02:51:45
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

 import 'dart:ui';

import 'package:dramasource/core/model/setting.dart';
import 'package:get/get.dart';

Locale? getLocale() {
    return getLocaleByLanguage(Setting.getLanguage());
}


Locale ? getLocaleByLanguage(int language){
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






