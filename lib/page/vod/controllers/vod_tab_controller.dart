/*
 * @File     : vod_tab_controller.dart
 * @Author   : jade
 * @Date     : 2024/07/16 11:25:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodTabController extends GetxController with GetSingleTickerProviderStateMixin {
  final List<Widget> items = <Widget>[];
  final List<Widget> tabs = [];
  late TabController tabController;
  final int pageCount;
  VodTabController(this.pageCount);

  @override
  void onInit() {
     for (int i = 0; i < pageCount; i++) {
      tabs.add(Tab(text:"Tab$i"));
      items.add(Text(i.toString()));
    }
    tabController = TabController(length: pageCount, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
