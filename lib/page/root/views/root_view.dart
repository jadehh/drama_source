/*
 * @Author: jadehh
 * @Date: 2024-07-11 16:31:51
 * @LastEditTime: 2024-07-29 13:29:37
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\root\views\root_view.dart
 * 
 */
import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/core/utils/file_util.dart';
import 'package:dramasource/page/root/controllers/root_controller.dart';
import 'package:dramasource/page/root/views/buttom_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
        init: RootController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(FileUtil.getWall(Setting.getWall())),
                      fit: BoxFit.fill),
                ),
              ),
              Obx(
                () {
                  return controller.screens[controller.bottombarIndex.value];
                }
              
               ),
              const ButtomView(),
            ]),
          );
        });
  }
}
