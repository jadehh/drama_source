/*
 * @Author: jadehh
 * @Date: 2024-07-11 16:31:51
 * @LastEditTime: 2024-08-15 19:11:49
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\root\views\root_view.dart
 * 
 */
import 'package:dramasource/page/base/views/base_background_container_view.dart';
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
          return GetBuilder<RootController>(
            id: "wall",
            builder: (controller) {
              return Scaffold(
                  body: BaseBackgroundContainer(
                Column(children: <Widget>[
                  Expanded(
                    child: Obx(() {
                      return controller
                          .screens[controller.bottombarIndex.value];
                    }),
                  ),
                  const ButtomView(),
                ]),
              ));
            },
          );
        });
  }
}
