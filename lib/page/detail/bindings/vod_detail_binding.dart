/*
 * @Author: jadehh
 * @Date: 2024-07-30 14:29:45
 * @LastEditTime: 2024-07-30 14:30:02
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\detail\bindings\detail_binding.dart
 * 
 */

import 'package:dramasource/page/detail/controllers/vod_detail_controller.dart';
import 'package:get/get.dart';


class VodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VodDetailController>(() => VodDetailController(), fenix: true);
  }
}






