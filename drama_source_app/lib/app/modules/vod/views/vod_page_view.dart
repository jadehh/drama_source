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
import 'package:drama_source_app/app/modules/vod/controllers/vod_list_controller.dart';
import 'package:drama_source_app/widgets/cards/vod_card.dart';
import 'package:drama_source_app/widgets/keep_alive_wrapper.dart';
import 'package:drama_source_app/widgets/page_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VodPageView extends StatelessWidget {
  final String tag;

  const VodPageView({required this.tag, super.key});

  VodListController get controller => Get.find<VodListController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    var c = MediaQuery.of(context).size.width ~/ 200;
    if (c < 2) {
      c = 2;
    }
    return KeepAliveWrapper(
      child: PageGridView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA12,
        firstRefresh: true,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        crossAxisCount: c,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return VodCard(controller.siteViewModel, item);
        },
      ),
    );
  }
}
