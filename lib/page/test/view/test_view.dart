/*
 * @File     : test_view.dart
 * @Author   : jade
 * @Date     : 2024/08/15 07:03:07
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class TestView extends GetView {
  const TestView({super.key});

 @override
  Widget build(BuildContext context) {
    var data = "IMG_100232321321312312312312312321321312321343024哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
         
    return Scaffold(
        body:  Row(
      children: <Widget>[
        const Spacer(),
        Expanded(
          child: Text(
            data.length > 1 ? data.substring(0, data.length~/2) : data,
            maxLines: 1,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            data.length > 1 ? data.substring(data.length~/2 - 1) : '',
            maxLines: 1,
            textAlign: TextAlign.start,
          ),
        ),
        const Spacer(),
      ],
)
    );
  }
}






