/*
 * @File     : root_app_bar_view
 * @Author   : jade
 * @Date     : 2024/07/29 09:43:48
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/material.dart';

class SettingAppBarView extends StatelessWidget {
  final String title;
  const SettingAppBarView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // 设置主轴对齐方式为左对齐
        children: [
          Expanded(
              child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.upload,
                color: Colors.white,
              )),
          const Padding(padding: EdgeInsets.only(right: 18)),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              )),
          const Padding(padding: EdgeInsets.only(right: 2)),
        ],
      ),
    );
  }
}
