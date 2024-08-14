/*
 * @File     : normal_setting_view.dart
 * @Author   : jade
 * @Date     : 2024/07/16 05:24:24
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/event/focus_state.dart';
import 'package:dramasource/page/setting/controllers/normal_setting_controller.dart';
import 'package:dramasource/theme/out_line_button_custom_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NormalSettingView extends GetView<NormalSettingController> {
  final String name;
  final String text;
  final VoidCallback onPressed;
  const NormalSettingView(this.name, this.text, this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: FocusState.instance.focusWidget(OutlinedButton(
        style: OutLineButtonCustomStyle().lightSettingOutlineButtonStyle(), 
        onPressed: onPressed,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(name)),
              Text(text),
            ]),
      )),
    );
  }
}
