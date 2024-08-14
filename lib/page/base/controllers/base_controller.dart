/*
 * @File     : base_controller.dart
 * @Author   : jade
 * @Date     : 2024/07/19 03:09:34
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:dramasource/event/event.dart';
import 'package:dramasource/event/refresh_event.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    EventBusUtil.instance.getDefaultEvent().on<RefreshEvent>().listen((event) {
      if (event.type == Type.wall) {
        if (kDebugMode) {
          print(this);
        }
        update(['wall']);
      } 
    });
  }

  

  @override
  void dispose() {
    EventBusUtil.instance.getDefaultEvent().destroy();
    super.dispose();
  }
}
