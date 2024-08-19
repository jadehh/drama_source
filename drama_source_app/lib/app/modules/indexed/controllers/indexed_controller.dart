/*
 * @Author: jadehh
 * @Date: 2024-08-19 13:47:14
 * @LastEditTime: 2024-08-19 16:41:37
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\modules\indexed\controllers\indexed_controller.dart
 * 
 */


import 'package:drama_source_app/app/constant.dart';
import 'package:drama_source_app/app/modules/vod/controllers/vod_controller.dart';
import 'package:drama_source_app/app/modules/vod/views/vod_view.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';


class IndexedController extends GetxController {
  RxList<HomePageItem> items = RxList<HomePageItem>([]);

  var index = 0.obs;
  RxList<Widget> pages = RxList<Widget>([
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ]);

  void setIndex(int i) {
    if (pages[i] is SizedBox) {
      switch (items[i].index) {
        case 0:
          Get.put(VodController());
          pages[i] = const VodView();
          break;
        // case 1:
        //   Get.put(FollowUserController());
        //   pages[i] = const FollowUserPage();
        //   break;
        // case 2:
        //   Get.put(CategoryController());
        //   pages[i] = const CategoryPage();
        //   break;
        // case 3:
        //   pages[i] = const MinePage();
        //   break;
        default:
      }
    } else {
      if (index.value == i) {
        // EventBus.instance
        //     .emit<int>(EventBus.kBottomNavigationBarClicked, items[i].index);
      }
    }

    index.value = i;
  }

  @override
  void onInit() {
    Future.delayed(Duration.zero, showFirstRun);
    items.value = AppSettingsController.instance.homeSort
        .map((key) => Constant.allHomePages[key]!)
        .toList();
    setIndex(0);
    super.onInit();
  }

  void showFirstRun() async {
    var settingsController = Get.find<AppSettingsController>();
    if (settingsController.firstRun) {
      settingsController.setNoFirstRun();
      await Utils.showStatement();
      Utils.checkUpdate();
    } else {
      Utils.checkUpdate();
    }
  }
}
