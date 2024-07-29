/*
 * @File     : buttom_view.dart
 * @Author   : jade
 * @Date     : 2024/07/24 04:55:22
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/page/root/controllers/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtomView extends GetView<RootController> {
  const ButtomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tooltip(
                  message: Local.navVod.tr,
                  child: IconButton(
                      onPressed: () {
                        controller.changeBottomBarIndex(0);
                      },
                      icon: const Icon(Icons.video_label))),
              Tooltip(
                  message: Local.navSetting.tr,
                  child: IconButton(
                      onPressed: () {
                        controller.changeBottomBarIndex(1);
                      },
                      icon: const Icon(Icons.settings))),
              Tooltip(
                  message: Local.navDownload.tr,
                  child: IconButton(
                      onPressed: () {
                        controller.changeBottomBarIndex(2);
                      },
                      icon: const Icon(Icons.download))),
            ],
          ),
        ));
  }
}
