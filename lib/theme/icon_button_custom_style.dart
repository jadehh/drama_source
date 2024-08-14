/*
 * @File     : icon_button_custom_style.dart
 * @Author   : jade
 * @Date     : 2024/08/09 09:19:15
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
//

import 'package:flutter/material.dart';

class IconButtonCustomStyle {
  ButtonStyle lightIconButtonNormalStyle() {
    return ButtonStyle(overlayColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) {
        return Colors.blue.withOpacity(0.5); // 选中状态下的颜色
      }
      return null;
    }));
  }
}
