/*
 * @Author: jadehh
 * @Date: 2024-08-19 14:06:18
 * @LastEditTime: 2024-08-19 15:14:37
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\constant.dart
 * 
 */
import 'package:drama_source_core/src/model/local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class Constant {
  static final Map<String, HomePageItem> allHomePages = {
    "vod": HomePageItem(
      iconData: Remix.video_on_line,
      title: Local.navVod.tr,
      index: 0,
    ),
    "live": HomePageItem(
      iconData: Remix.live_line,
      title: Local.navLive,
      index: 1,
    ),

    "setting": HomePageItem(
      iconData: Remix.settings_line,
      title: Local.navSetting.tr,
      index: 2,
    ),

    "download": HomePageItem(
      iconData: Remix.download_line,
      title: Local.navDownload.tr,
      index: 3,
    ),
  };
}

class HomePageItem {
  final IconData iconData;
  final String title;
  final int index;
  HomePageItem({
    required this.iconData,
    required this.title,
    required this.index,
  });
}
