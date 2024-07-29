/*
 * @Author: jadehh
 * @Date: 2024-07-16 19:30:30
 * @LastEditTime: 2024-07-17 09:33:39
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\views\custom_setting_view.dart
 * 
 */
import 'package:dramasource/page/setting/controllers/normal_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSettingView extends GetView<NormalSettingController> {
  final String name;
  final String text;
  final VoidCallback onPressed;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final IconData iconData;
  const CustomSettingView(this.name, this.text, this.onPressed,this.onPressed1, this.onPressed2,this.iconData,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        // 边框的样式
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black.withOpacity(0.1)),
                    child: ListTile(
                      onTap: () {
                        onPressed();
                      },
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(name),
                            Text(text),
                          ]),
                    ))),
            const Padding(padding: EdgeInsets.only(left: 8)),
            IconButton(
                onPressed: onPressed1,
                icon: const Icon(
                  Icons.home,
                  size: 32,
                )),
                            const Padding(padding: EdgeInsets.only(left: 8)),
            IconButton(
                onPressed: onPressed2,
                icon:  Icon(
                  iconData,
                  size: 32,
                ))
          ],
        ));
  }
}
