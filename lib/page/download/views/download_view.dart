/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-07-11 14:24:10
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\download\views\download_view.dart
 * 
 */
import 'package:dramasource/page/download/controllers/download_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DownloadView extends GetView<DownloadController> {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Download"));
  }
}
