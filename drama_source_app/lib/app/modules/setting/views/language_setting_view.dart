/*
 * @Author: jadehh
 * @Date: 2024-07-15 15:11:47
 * @LastEditTime: 2024-07-29 14:22:20
 * @LastEditors: jadehh
 * @Description: 语言设置页面
 * @FilePath: \dramasource\lib\page\setting\views\language_setting_view.dart
 * 
 */

import 'package:drama_source_app/app/modules/setting/controllers/language_setting_controller.dart';
import 'package:drama_source_app/widgets/base_app_bar_view.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSettingsView extends GetView<LanguageSettingsController> {
  const LanguageSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageSettingsController>(
        init: LanguageSettingsController(),
        builder: (controller) {
          return Scaffold(
              body: Column(
            children: [
              BaseAppBarView(Local.setting_language.tr),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Obx(() => Container(
                              padding:const EdgeInsets.only(left: 16, right: 16),
                              height: 50,
                              child: InkWell(
                                onTap: () async {
                                  await controller.changeLanguage(index);
                                  Get.back(result: index);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            controller.languageList[index])),
                                    Visibility(
                                        visible: controller
                                                .currentLanguageIndex.value ==
                                            index,
                                        child: const Icon(Icons.check_rounded,
                                            color: Colors.blue))
                                  ],
                                ),
                              ),
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 1,
                        );
                      },
                      itemCount: controller.languageList.length),
                ),
              )
            ],
          ));
        });
  }
}
