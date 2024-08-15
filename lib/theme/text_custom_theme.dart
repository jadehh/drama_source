/*
 * @File     : test_custom_style.dart
 * @Author   : jade
 * @Date     : 2024/8/14 上午11:08
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:flutter/material.dart';

class TextCustomTheme {
  TextTheme textNormalTheme() {
    return const TextTheme(
    bodyMedium: TextStyle(
      // fontFamily: 'Alima ma FangYuanTi VF',
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      // fontFamily: 'Alima ma FangYuanTi VF',
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold
    ),
  );
  }
}
