/*
 * @File     : normal_setting_view.dart
 * @Author   : jade
 * @Date     : 2024/07/16 05:24:24
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/page/setting/controllers/normal_setting_controller.dart';
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
        child: Container(
          decoration: BoxDecoration(
            // 边框的样式
            border: Border.all(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.black.withOpacity(0.1),
          ),
          child: ListTile(
            onTap: () {
              onPressed();
            },
            title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                child: Text(name),
              ),
              Text(text, style: const TextStyle(fontSize: 12)),
              const Padding(padding: EdgeInsets.only(left: 10)),
              const Icon(Icons.chevron_right)
            ]),
          ),
        ));
  }
}
