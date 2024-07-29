/*
 * @Author: jadehh
 * @Date: 2024-07-11 16:33:55
 * @LastEditTime: 2024-07-29 13:54:54
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\views\setting_view.dart
 * 
 */
import 'package:dramasource/core/config/wall_config.dart';
import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/page/base/views/base_background_container_view.dart';
import 'package:dramasource/page/setting/views/setting_app_bar_view.dart';
import 'package:dramasource/page/setting/controllers/setting_controller.dart';
import 'package:dramasource/page/setting/views/custom_setting_view.dart';
import 'package:dramasource/page/setting/views/normal_setting_view.dart';
import 'package:dramasource/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        init: SettingController(),
        builder: (controller) {
          return Scaffold(
              body: GetBuilder<SettingController>(
                  id: 'wall',
                  builder: (controller) {
                    return BaseBackgroundContainer(Column(
                      children: [
                        SettingAppBarView(Local.navSetting.tr),
                        Expanded(
                            child: ListView(children: [
                          CustomSettingView(Local.navVod.tr, "https://", () {},
                              () {}, () {}, Icons.history),
                          CustomSettingView(Local.navLive.tr, "https://", () {},
                              () {}, () {}, Icons.history),
                          CustomSettingView(
                              Local.wallPaper.tr, "https://", () {}, () {
                            WallConfig.refresh(Setting.getWall() == 4
                                ? 1
                                : Setting.getWall() + 1);
                          }, () {}, Icons.refresh),
                          NormalSettingView(Local.languageSetting.tr,
                              controller.languageStr.value, () {
                            Get.toNamed(Routes.LANGUAGESETTING)?.then((value) {
                              controller.getLanguage();
                            });
                          }),
                          NormalSettingView(
                              Local.about.tr, Setting.getVersion(), () {}),
                        ]))
                      ],
                    ));
                  }));
        });
  }
}
