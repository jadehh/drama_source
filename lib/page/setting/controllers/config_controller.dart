/*
 * @File     : config_controller.dart
 * @Author   : jade
 * @Date     : 2024/08/14 05:04:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/api/config/vod_config.dart';
import 'package:dramasource/db/bean/config.dart';
import 'package:dramasource/page/setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  int type = 0;
  TextEditingController textController = TextEditingController(text: 'Initial value');

  @override
  Future<void> onInit() async {
    super.onInit();
    Config? config = await getConfig();
    textController.text = config!.url ?? "";
  }

  ConfigController(int vodType){
    type = vodType;
  }
      
  void changeTextFileText(String text) {
    textController.text = text;
  }
  Future <Config?> getConfig() async{
        switch (type) {
            case 0:
                return await VodConfig.get().getConfig();
            case 1:
                return await VodConfig.get().getConfig();
            case 2:
                return await VodConfig.get().getConfig();
            default:
                return null;
        }
    }

    setConfig(String url) async{
      Config config = await Config().findUrlAndType(url,type);
      final controller = Get.find<SettingController>();
      controller.setConfig(config);
    }

}
