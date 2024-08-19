/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-08-19 16:34:20
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\modules\vod\views\vod_view.dart
 * 
 */
import 'package:drama_source_app/app/modules/vod/controllers/vod_controller.dart';
import 'package:drama_source_app/app/modules/vod/views/appbar_view.dart';
import 'package:drama_source_app/app/modules/vod/views/vod_tab_view.dart';
import 'package:drama_source_app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodView extends GetView<VodController> {
  const VodView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Container(
          child: const Column(children: [
        SizedBox(
          height: 60.0, // 设置高度
          child: AppBarView(),
        ),
        Expanded(child: VodTabView(10)),
      ])),
    );
  }
}
