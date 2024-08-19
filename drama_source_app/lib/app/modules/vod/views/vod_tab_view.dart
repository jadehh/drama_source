/*
 * @File     : vod_tab_view.dart
 * @Author   : jade
 * @Date     : 2024/07/16 11:24:51
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/modules/vod/controllers/vod_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class VodTabView extends GetView<VodTabController> {
  final int pageCount;
  const VodTabView(this.pageCount, {super.key});

  @override
  Widget build(BuildContext context) {
    VodTabController controller = Get.put(VodTabController(pageCount));
    return Column(children: [
      TabBar(
        indicatorColor: Colors.transparent,
        labelPadding: AppStyle.edgeInsetsA8,
        controller: controller.tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: controller.tabs,
      ),
      Expanded(
        child: TabBarView(
            controller: controller.tabController, children: controller.items),
      )
    ]);
  }
}
