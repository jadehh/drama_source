/*
 * @Author: jadehh
 * @Date: 2024-07-11 16:33:55
 * @LastEditTime: 2024-08-21 17:19:44
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\modules\setting\views\setting_view.dart
 * 
 */

import 'package:drama_source_app/app/modules/setting/controllers/setting_controller.dart';
import 'package:drama_source_app/app/modules/setting/dialog/language_setting_dialog.dart';
import 'package:drama_source_app/app/modules/setting/views/custom_setting_view.dart';
import 'package:drama_source_app/app/modules/setting/views/normal_setting_view.dart';
import 'package:drama_source_app/app/modules/setting/views/setting_app_bar_view.dart';
import 'package:drama_source_app/routes/route_path.dart';
import 'package:drama_source_app/widgets/app_scaffold.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingAppBarView(Local.nav_setting.tr),
        Expanded(
            child: ListView(children: [
          Obx(() => CustomSettingView(
                  Local.setting_vod.tr, controller.vodUrl.value, () {
                controller.openDialog(0);
              }, () {}, () {}, Icons.history)),
          Obx(() => CustomSettingView(
                  Local.setting_live.tr, controller.liveUrl.value, () {
                controller.openDialog(1);
              }, () {}, () {}, Icons.history)),
          Obx(
            () => CustomSettingView(
                Local.setting_wall.tr, controller.wallUrl.value, () {
              controller.openDialog(2);
            }, () async {
              await controller.setWallDefault();
            }, () async {
              await controller.setWallRefresh();
            }, Icons.refresh),
          ),
          NormalSettingView(Local.setting_player.tr, "", () {}),
          NormalSettingView(Local.setting_custom.tr, "", () {}),
          NormalSettingView(Local.setting_doh.tr, "", () {}),
          NormalSettingView(Local.setting_proxy.tr, "", () {}),
          Obx(()=>NormalSettingView(Local.setting_cache.tr, controller.cache.value, () {
            controller.onCache();
          })),
          Obx(() => NormalSettingView(
                  Local.setting_language.tr, controller.languageStr.value, () {
                // Get.toNamed(Routes.LANGUAGESETTING)?.then((value) {
                //   controller.getLanguage();
                // });
                Get.dialog(const LanguageSettingDialog());
              })),
          NormalSettingView(Local.setting_about.tr, Utils.packageInfo.version,
              () {
            Get.toNamed(RoutePath.kDetail, arguments: {
              "url":
                  "http://192.168.29.157:10086/hls/181/20240724/20240724153055/181_record.m3u8"
            });
          }),
        ]))
      ],
    );
  }
}
