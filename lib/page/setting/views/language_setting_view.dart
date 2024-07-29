/*
 * @Author: jadehh
 * @Date: 2024-07-15 15:11:47
 * @LastEditTime: 2024-07-29 14:22:20
 * @LastEditors: jadehh
 * @Description: 语言设置页面
 * @FilePath: \dramasource\lib\page\setting\views\language_setting_view.dart
 * 
 */
import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/page/base/views/base_app_bar_view.dart';
import 'package:dramasource/page/base/views/base_background_container_view.dart';
import 'package:dramasource/page/setting/controllers/language_setting_controller.dart';
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
              body: BaseBackgroundContainer(Column(
            children: [
              BaseAppBarView(Local.languageSetting.tr),
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
                                onTap: () {
                                  controller.changeLanguage(index);
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
          )));
        });
  }
}
