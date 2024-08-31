/*
 * @File     : config_controller.dart
 * @Author   : jade
 * @Date     : 2024/08/14 05:04:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_app/app/modules/setting/controllers/setting_controller.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  int type = 0;
  TextEditingController textController = TextEditingController(text: 'Initial value');

  @override
  Future<void> onInit() async {
    super.onInit();
    Config? config = await getConfig();
    textController.text = config!.getUrl() == null ? "":config.getUrl()!;
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
                return await LiveConfig.get().getConfig();
            case 2:
                return await WallConfig.get().getConfig();
            default:
                return null;
        }
    }

    setConfig(String url) async{
      Config? config = await Config.find(url: url,type: type);
      final controller = Get.find<SettingController>();
      await controller.setConfigByConfig(config!);
      Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
    }
}
