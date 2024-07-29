/*
 * @Author: jadehh
 * @Date: 2024-07-15 14:59:34
 * @LastEditTime: 2024-07-18 10:48:31
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\controllers\language_setting_controller.dart
 * 
 */
import 'package:dramasource/core/language/language_utils.dart';
import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/core/model/setting.dart';
import 'package:get/get.dart';


class LanguageSettingsController extends GetxController {

  final currentLanguageIndex = 0.obs;

  List<String> languageList = [
    Local.followerSystemLanguage.tr,
    '简体中文',
    '繁體中文',
    'English',
  ];

  @override
  void onInit() {
    super.onInit();
    currentLanguageIndex.value = Setting.getLanguage();
  }
  
  ///切换语言
  void changeLanguage(int language) {
    //保存到本地
    currentLanguageIndex.value =language;
    Setting.setLanguage(language);
    Get.updateLocale(getLocaleByLanguage(language)!);
    languageList.first = Local.followerSystemLanguage.tr;
  }
}

