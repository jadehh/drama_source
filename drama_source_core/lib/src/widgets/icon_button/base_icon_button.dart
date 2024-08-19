/*
 * @Author: jadehh
 * @Date: 2024-08-19 16:29:48
 * @LastEditTime: 2024-08-19 16:29:52
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\widgets\icon_button\base_icon_button.dart
 * 
 */
/*
 * @File     : base_icon_button.dart
 * @Author   : jade
 * @Date     : 2024/08/08 03:11:06
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  const BaseIconButton(this.iconData, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
