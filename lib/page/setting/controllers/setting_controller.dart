/*
 * @File     : setting_controller.dart
 * @Author   : jade
 * @Date     : 2024/07/11 04:34:12
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/page/base/controllers/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SettingController extends BaseController with WidgetsBindingObserver  {
  
  final languageStr = Local.followerSystemLanguage.tr.obs;

  
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getLanguage();
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    getLanguage();
  }


  //获取语言
  void getLanguage() {
    switch (Setting.getLanguage()) {
      case 0:
        languageStr.value = Local.followerSystemLanguage.tr;
        break;
      case 1:
        languageStr.value = Local.simplifiedChinese.tr;
        break;
      case 2:
        languageStr.value = "繁體中文";
        break;
      case 3:
        languageStr.value = 'English';
        break;
      default:
        languageStr.value = Local.followerSystemLanguage.tr;
        break;
    }
  }
}




