/*
 * @File     : vod_tab_controller.dart
 * @Author   : jade
 * @Date     : 2024/07/16 11:25:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/page/vod/views/type_view.dart';
import 'package:dramasource/page/vod/views/vod_items_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Widget> items = <Widget>[];
  final List<Widget> tabs = [];
  late TabController tabController;
  final int pageCount;

  VodTabController(this.pageCount);


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: pageCount, vsync: this);
    for (int i = 0; i < pageCount; i++) {
      tabs.add(TypeView(title: "tab$i", index: i, tabController: tabController));
      items.add(VodItemsView(tabControolerKey: UniqueKey()));
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
