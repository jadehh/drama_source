/*
 * @Author: jadehh
 * @Date: 2024-08-09 13:55:57
 * @LastEditTime: 2024-08-12 14:35:57
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\vod\views\vod_items_view.dart
 * 
 */
import 'package:dramasource/page/base/views/base_footer_view.dart';
import 'package:dramasource/page/vod/controllers/vod_items_controller.dart';
import 'package:dramasource/page/vod/views/vod_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VodItemsView extends StatelessWidget {
  final Key tabControolerKey;
  const VodItemsView({required this.tabControolerKey, super.key});
  @override
  Widget build(BuildContext context) {
    VodItemsController vodItemsController =
        Get.put(VodItemsController(), tag: tabControolerKey.toString());
    return GetBuilder<VodItemsController>(
        init: vodItemsController,
        id: "vod_items",
        builder: (controller) => SmartRefresher(
            footer: const BaseFooterView(),
            controller: vodItemsController.refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: vodItemsController.onRefresh,
            onLoading: vodItemsController.onLoading,
            child: GridView.builder(
              controller: vodItemsController.scrollController,
              padding: const EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _calculateColumnCount(context),
                mainAxisSpacing: 20.0, // 主轴间距
                crossAxisSpacing: 20.0,
                childAspectRatio: 0.7, // 子widget宽高比
              ),
              itemCount: vodItemsController.items.length,
              itemBuilder: (context, index) {
                return VodItemView(title: vodItemsController.items[index]);
              },
            )));
  }

  int _calculateColumnCount(BuildContext context) {
    // 获取屏幕宽度
    double width = MediaQuery.of(context).size.width;
    // 计算列数
    int columns = (width / 150).floor(); // 假设每个Item的宽度为150
    return columns > 0 ? columns : 1; // 至少有一列
  }
}
