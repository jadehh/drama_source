/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-07-19 15:22:07
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\vod\views\vod_view.dart
 * 
 */
import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/core/utils/file_util.dart';
import 'package:dramasource/page/vod/controllers/vod_controller.dart';
import 'package:dramasource/page/vod/views/appbar_view.dart';
import 'package:dramasource/page/vod/views/vod_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodView extends GetView<VodController> {


  const VodView({super.key});


  @override
  Widget build(BuildContext context) {
     return GetBuilder<VodController>(
        init: VodController(),
        builder: (controller) { return Scaffold(
        body: Container(
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(FileUtil.getWall(Setting.getWall())),
                  fit: BoxFit.cover),
            ),
          child: const Column(children: [
          SizedBox(
      height: 60.0, // 设置高度
      child: AppBarView(),
    ),
    Expanded(child: VodTabView(10)),
    ])));}); 
  }
}
