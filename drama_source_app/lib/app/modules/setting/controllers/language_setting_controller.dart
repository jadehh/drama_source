/*
 * @Author: jadehh
 * @Date: 2024-07-15 14:59:34
 * @LastEditTime: 2024-08-15 16:47:23
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\controllers\language_setting_controller.dart
 * 
 */

import 'package:drama_source_app/app/modules/setting/controllers/setting_controller.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:get/get.dart';


class LanguageSettingsController extends GetxController {

  final currentLanguageIndex = 0.obs;

  List<String> languageList = [
    Local.setting_fllow_system.tr,
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
  Future changeLanguage(int language) async{
    //保存到本地
    currentLanguageIndex.value =language;
    await Setting.putLanguage(language);
    Get.updateLocale(LanguageUtil.getLocaleByLanguage(language)!);
    languageList.first = Local.setting_language.tr;
    SettingController settingController = Get.find<SettingController>();
    settingController.getLanguage();
  }



}

