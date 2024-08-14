/*
 * @File     : base_image_icon_button.dart
 * @Author   : jade
 * @Date     : 2024/08/08 04:14:21
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/theme/out_line_button_custom_style.dart';
import 'package:flutter/material.dart';

class BaseImageIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  const BaseImageIconButton(this.iconData, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutLineButtonCustomStyle().lightSettingOutlineButtonStyle(),
      onPressed: onPressed,
      child: Icon(
        size: 32,
        iconData,
        color: Colors.white,
      ),
    );
  }
}
