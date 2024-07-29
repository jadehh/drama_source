/*
 * @File     : vod_tab_view.dart
 * @Author   : jade
 * @Date     : 2024/07/16 11:24:51
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/page/vod/controllers/vod_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodTabView extends GetView<VodTabController> {
  final int pageCount;
  const VodTabView(this.pageCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VodTabController>(
        init: VodTabController(pageCount),
        builder: (controller) {
          return DefaultTabController(
            length: pageCount,
            child: Column(children: [
              TabBar(
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20), // 设置水平内边距
                labelColor: Colors.blue,
                controller: controller.tabController,
                tabs: controller.tabs,
                isScrollable: true,
              ),
              Expanded(
                  child: TabBarView(
                      controller: controller.tabController,
                      children: controller.items))
            ]),
          );
        });
  }
}
