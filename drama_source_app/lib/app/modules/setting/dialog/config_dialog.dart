/*
 * @Author: jadehh
 * @Date: 2024-08-14 17:02:53
 * @LastEditTime: 2024-08-15 20:00:52
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\dialog\config_dialog.dart
 * 
 */


import 'package:drama_source_app/app/modules/setting/controllers/config_controller.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigDialog extends GetView<ConfigController> {
  final int type;
  const ConfigDialog({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    //
    return GetBuilder(
        init: ConfigController(type),
        builder: (controller) => AlertDialog(
              title:  Text(
                type == 0 ? Local.setting_vod.tr : type == 1 ? Local.setting_live.tr : Local.setting_wall.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 250,child: TextField(
                    style: const TextStyle(height: 2),
                    controller: controller.textController,
                    decoration: InputDecoration(
                      labelText: Local.configHit.tr,
                      isDense: true,
                      suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(Icons.folder,
                                  color: Colors.grey,size: 24,))),
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                  ),),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                      
                        onPressed: () {
                          Navigator.of(Get.overlayContext!, rootNavigator: true)
                              .pop();
                        },
                        child: Text(Local.cancel.tr)),
                    TextButton(
                        onPressed: () async {
                          //确定
                          String url = UrlUtil.fixUrl(controller.textController.text.toString().trim());                          
                          await controller.setConfig(url);
                        },
                        child: Text(Local.confirm.tr)),
                  ])
                ],
              ),
              backgroundColor: Colors.white,
            ));
  }
}
