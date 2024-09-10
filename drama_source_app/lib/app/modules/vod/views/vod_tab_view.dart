/*
 * @File     : vod_tab_view.dart
 * @Author   : jade
 * @Date     : 2024/07/16 11:24:51
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/modules/vod/controllers/vod_controller.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';

class VodTabView extends StatelessWidget {
  final Result result;
  final VodController vodController;
  const VodTabView(this.result, this.vodController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
        indicatorColor: Colors.transparent,
        labelPadding: AppStyle.edgeInsetsA8,
        controller: vodController.tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: vodController.tabs,
      ),
      Expanded(
        child: TabBarView(controller: vodController.tabController, children: vodController.items),
      )
    ]);
  }
}
