/*
 * @Author: jadehh
 * @Date: 2024-07-16 19:30:30
 * @LastEditTime: 2024-08-15 19:36:57
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\views\custom_setting_view.dart
 * 
 */

import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/modules/setting/controllers/normal_setting_controller.dart';
import 'package:drama_source_app/widgets/icon_button/base_image_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSettingView extends GetView<NormalSettingController> {
  final String name;
  final String text;
  final VoidCallback onPressed;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final IconData iconData;
  const CustomSettingView(this.name, this.text, this.onPressed, this.onPressed1, this.onPressed2, this.iconData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: OutlinedButton(
              style: AppStyle.lightSettingOutlineButtonStyle(),
              onPressed: onPressed,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Expanded(child: Text(text,overflow: TextOverflow.ellipsis)),
                  ]),
            )),
            const Padding(padding: EdgeInsets.only(left: 20)),
            BaseImageIconButton(Icons.home, onPressed1),
            const Padding(padding: EdgeInsets.only(left: 20)),
            BaseImageIconButton(iconData, onPressed2),
          ]

        ));
  }
}
