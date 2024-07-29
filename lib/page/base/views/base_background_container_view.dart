/*
 * @Author: jadehh
 * @Date: 2024-07-29 13:38:18
 * @LastEditTime: 2024-07-29 13:40:28
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\base\views\base_background_container.dart
 * 
 */

import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/core/utils/file_util.dart';
import 'package:flutter/material.dart';

class BaseBackgroundContainer extends StatelessWidget {
  final Widget widget;
  const BaseBackgroundContainer(this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(FileUtil.getWall(Setting.getWall())),
            fit: BoxFit.cover),
      ),
      child: widget,
    );
  }
}
