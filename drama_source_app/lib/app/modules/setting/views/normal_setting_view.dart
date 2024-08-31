/*
 * @File     : normal_setting_view.dart
 * @Author   : jade
 * @Date     : 2024/07/16 05:24:24
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/modules/setting/controllers/normal_setting_controller.dart';
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
      child: OutlinedButton(
        style: AppStyle.lightSettingOutlineButtonStyle(), 
        onPressed: onPressed,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(name)),
              Text(text),
            ]),
      ),
    );
  }
}
