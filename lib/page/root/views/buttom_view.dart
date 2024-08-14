/*
 * @File     : buttom_view.dart
 * @Author   : jade
 * @Date     : 2024/07/24 04:55:22
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/event/focus_state.dart';
import 'package:dramasource/page/base/views/base_icon_button.dart';
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
                child: FocusState.instance.focusWidget(
                 BaseIconButton(Icons.video_label, (){
                      controller.changeBottomBarIndex(0);
                 }) 
                )
              ),
              Tooltip(
                  message: Local.navSetting.tr,
                  child: FocusState.instance.focusWidget(BaseIconButton(Icons.settings, (){
                        controller.changeBottomBarIndex(1);
                  }))),
              Tooltip(
                  message: Local.navDownload.tr,
                  child:FocusState.instance.focusWidget(BaseIconButton(Icons.download, (){
                        controller.changeBottomBarIndex(2);
                  }))),
            ],
          ),
        ));
  }
}
