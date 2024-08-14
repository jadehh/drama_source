/*
 * @Author: jadehh
 * @Date: 2024-08-09 09:11:21
 * @LastEditTime: 2024-08-09 10:15:19
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\theme\out_line_button_custom_style.dart
 * 
 */

import 'package:flutter/material.dart';

class OutLineButtonCustomStyle {
  ButtonStyle lightOutLineButtonNormalStyle() {
    return ButtonStyle(
      side: WidgetStateProperty.all(
         BorderSide(color: Colors.black.withOpacity(0.1)), // 设置边框颜色为蓝色
      ),
      minimumSize: WidgetStateProperty.all(
        const Size(40, 60), // 设置按钮的最小宽度和高度
      ),
      overlayColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed) ) {
          return Colors.blue.withOpacity(0.5); // 选中状态下的颜色
        }
        return null;
      }),
      backgroundColor:
          WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.1)),
    );
  }

  ButtonStyle lightTabOutlineButtonStyle() {
    return ButtonStyle(
        minimumSize: WidgetStateProperty.all(
      const Size(40, 40), // 设置按钮的最小宽度和高度
    ));
  }

  ButtonStyle lightSettingOutlineButtonStyle() {
    return ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.fromLTRB(16, 0, 16, 0),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16),
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    );
  }
}
