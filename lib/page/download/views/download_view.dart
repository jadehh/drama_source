/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-08-13 15:09:23
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
    return   Scaffold(
      appBar: AppBar(
        title: Text("GetX Title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  barrierDismissible: false,
                  title: "删除",
                  middleText: "您确定要删除吗?",
                  //确定按钮
                  confirm: ElevatedButton(
                      onPressed: () {
                        //单击后删除弹框
                        Get.back(closeOverlays: true);
                      },
                      child:const Text("确定")),
                  //取消按钮
                  cancel: ElevatedButton(
                      onPressed: () {
                        //单击后删除弹框
                        Get.back(closeOverlays: true);
                      },
                      child:const  Text("取消")),
                      
                );
 
              },
              child: Text("显示 Dialog"))
          ],
        ),
      ),
    );
  }
}
