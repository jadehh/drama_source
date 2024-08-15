/*
 * @File     : home_controller.dart
 * @Author   : jade
 * @Date     : 2024/07/16 03:55:30
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:dramasource/page/base/controllers/base_controller.dart';
import 'package:dramasource/page/download/views/download_view.dart';
import 'package:dramasource/page/setting/views/language_setting_view.dart';
import 'package:dramasource/page/setting/views/setting_view.dart';
import 'package:dramasource/page/test/view/test_view.dart';
import 'package:dramasource/page/vod/views/vod_view.dart';
import 'package:get/get.dart';

class RootController extends BaseController {
  RxInt bottombarIndex = 0.obs;
  List screens = [];

  @override
  void onInit() {
    screens.add(const VodView());
    screens.add(const SettingView());
    screens.add(const DownloadView());
    screens.add(const TestView());
    super.onInit();
  }

  //改变底部导航栏索引
  changeBottomBarIndex(int index) {
    bottombarIndex.value = index;
  }
}





