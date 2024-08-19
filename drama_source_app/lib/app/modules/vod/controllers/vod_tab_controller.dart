/*
 * @File     : vod_tab_controller.dart
 * @Author   : jade
 * @Date     : 2024/07/16 11:25:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:drama_source_app/app/modules/vod/views/vod_page_view.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Widget> items = <Widget>[];
  final List<Widget> tabs = [];
  late TabController tabController;
  final int pageCount;
  final tabIndex = 0.obs;
  late final List<AppFocusNode> _focusList = [];

  initView() {
    for (int i = 0; i < pageCount; i++) {
      AppFocusNode appFocusNode = AppFocusNode();
      
      _focusList.add(appFocusNode);
      tabs.add(AppStyle.hGap32);
      tabs.add(
        Obx(
          () => HighlightButton(
            focusNode:appFocusNode,
            text: "Vod $i",
            selected: tabIndex.value == i,
            onTap: () {
              tabController.animateTo(i);
            },
          ),
        ),
      );
      items.add(VodPageView(tabControolerKey: UniqueKey()));
    }
  }

  VodTabController(this.pageCount) {
    initView();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: pageCount, vsync: this);
    tabController.animation?.addListener(() {
      var currentIndex = (tabController.animation?.value ?? 0).round();
      if (tabIndex.value == currentIndex) {
        return;
      }
      tabIndex.value = currentIndex;
      _focusList[currentIndex].requestFocus();
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
