/*
 * @Author: jadehh
 * @Date: 2024-08-09 13:55:57
 * @LastEditTime: 2024-08-20 10:26:58
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\modules\vod\views\vod_page_view.dart
 * 
 */
import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/modules/vod/controllers/vod_items_controller.dart';
import 'package:drama_source_app/widgets/base_footer_view.dart';
import 'package:drama_source_app/widgets/cards/live_room_card.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';




class VodPageView extends StatelessWidget {
  final Key tabControolerKey;
  const VodPageView({required this.tabControolerKey, super.key});
  @override
  Widget build(BuildContext context) {
    VodItemsController vodItemsController =
        Get.put(VodItemsController(), tag: tabControolerKey.toString());
    return SmartRefresher(
            footer: const BaseFooterView(),
            controller: vodItemsController.refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: vodItemsController.onRefresh,
            onLoading: vodItemsController.onLoading,
            child: MasonryGridView.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              padding: AppStyle.edgeInsetsA24,
              itemCount: vodItemsController.items.length,
              itemBuilder: (context, index) {
                 return LiveRoomCard(
               
                  );       
              }, crossAxisCount: Utils.calculateColumnCount(context, 120),
            ));
  }

}