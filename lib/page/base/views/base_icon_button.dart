/*
 * @File     : base_icon_button.dart
 * @Author   : jade
 * @Date     : 2024/08/08 03:11:06
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/theme/icon_button_custom_style.dart';
import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  const BaseIconButton(this.iconData, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButtonCustomStyle().lightIconButtonNormalStyle(),
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
