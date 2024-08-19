/*
 * @File     : vod_tab_view.dart
 * @Author   : jade
 * @Date     : 2024/07/16 11:24:51
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:drama_source_app/app/modules/vod/controllers/vod_tab_controller.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodTabView extends GetView<VodTabController> {
  final int pageCount;
  const VodTabView(this.pageCount, {super.key});

  @override
  Widget build(BuildContext context) {
    VodTabController controller = Get.put(VodTabController(pageCount));
    return Scaffold(
        body: Column(children: [
      AppStyle.vGap48,
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: controller.tabs,
      ),
      Expanded(
        child: TabBarView(
            controller: controller.tabController, children: controller.items),
      )
    ]));
  }
}
