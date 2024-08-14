/*
 * @Author: jadehh
 * @Date: 2024-07-11 16:34:04
 * @LastEditTime: 2024-07-30 14:31:43
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\bindings\setting_binding.dart
 * 
 */
import 'package:dramasource/page/setting/controllers/setting_controller.dart';
import 'package:get/get.dart';


class SettingdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
  }
}






