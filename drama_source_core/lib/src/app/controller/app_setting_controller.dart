/*
 * @Author: jadehh
 * @Date: 2024-08-19 14:16:24
 * @LastEditTime: 2024-08-19 15:03:44
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\controller\app_setting_controller.dart
 * 
 */
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/model/prefers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  static AppSettingsController get instance => Get.find<AppSettingsController>();

  /// 缩放模式
  var scaleMode = 0.obs;

  var themeMode = 0.obs;

  var firstRun = false;

  var logEnable = false.obs;

  RxList<String> homeSort = RxList<String>();


  @override
  void onInit() {

    themeMode.value = Setting.getTheme();
    firstRun = Setting.getFirstRun(true); 
    scaleMode.value = Setting.getScaleModel();
    logEnable.value = Setting.getLogEnable();

    if (logEnable.value) {
      Log.initWriter();
    }
    super.onInit();
  }

  initHomeSort(Map<String, dynamic> allHomePages){
    var sort = Prefers.instance
        .getValue(
          Prefers.kHomeSort,
         allHomePages.keys.join(","),
        )
        .split(",");
    //如果数量与allSites的数量不一致，将缺失的添加上
    if (sort.length != allHomePages.length) {
      var keys = allHomePages.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        if (!sort.contains(keys[i])) {
          sort.add(keys[i]);
        }
      }
    }

    homeSort.value = sort;
  }

  var isDynamic = false.obs;
  void setIsDynamic(bool e) {
    isDynamic.value = e;
  }

  var styleColor = 0xff3498db.obs;
  void setStyleColor(int e) {
    styleColor.value = e;
  }



  void setNoFirstRun() {
    Setting.setFirstRun();
  }

  void changeTheme() {
    Get.dialog(
      SimpleDialog(
        title: const Text("设置主题"),
        children: [
          RadioListTile<int>(
            title: const Text("跟随系统"),
            value: 0,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 0);
            },
          ),
          RadioListTile<int>(
            title: const Text("浅色模式"),
            value: 1,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 1);
            },
          ),
          RadioListTile<int>(
            title: const Text("深色模式"),
            value: 2,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 2);
            },
          ),
        ],
      ),
    );
  }

  void setTheme(int i) {
    themeMode.value = i;
    var mode = ThemeMode.values[i];
    Setting.setTheme(i);
    Get.changeThemeMode(mode);
  }

}




