/*
 * @File     : text_buttom_custom_style.dart
 * @Author   : jade
 * @Date     : 2024/08/09 01:02:55
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/material.dart';

class TextButtomCustomStyle {
  ButtonStyle lightTextButtonNormalStyle() {
    return ButtonStyle(
      alignment: Alignment.centerLeft,
      minimumSize: WidgetStateProperty.all(
        const Size(40, 60), // 设置按钮的最小宽度和高度
      ),
         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      overlayColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.pressed)) {
          return Colors.blue.withOpacity(0.5); // 选中状态下的颜色
        }
        return null;
      }),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 14)
      )
      
    );
  }
}
