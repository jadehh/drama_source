/*
 * @Author: jadehh
 * @Date: 2024-08-13 11:19:42
 * @LastEditTime: 2024-08-13 16:52:19
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\dialog\language_setting_dialog.dart
 * 
 */


import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/page/setting/controllers/language_setting_controller.dart';
import 'package:dramasource/page/setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LanguageSettingDialog extends GetView<LanguageSettingsController> {

   LanguageSettingDialog({super.key});
  
  @override
  Widget build(BuildContext context) {
    // 
    return GetBuilder(
      init: LanguageSettingsController(),
      builder:(controller) =>  AlertDialog(
      title: const Text(Local.languageSetting,style: TextStyle(fontSize: 16),),
      content:SizedBox(
        width: 150,
        height: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Expanded(child: ListView.builder(
              itemCount: controller.languageList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(  controlAffinity: ListTileControlAffinity.leading,value: index==controller.currentLanguageIndex.value, onChanged: (value) {
                   controller.changeLanguage(index);
                   Navigator.of(Get.overlayContext!, rootNavigator: true).pop();     
              },title:  Text(controller.languageList[index],style: const TextStyle(fontSize: 16),),);
              },
            )),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Row(mainAxisAlignment: MainAxisAlignment.end,children: [TextButton(onPressed: (){
              Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
            }, child: const Text(Local.cancel))])
        ],
        )),
      backgroundColor: Colors.white,
      ));
  }
}



