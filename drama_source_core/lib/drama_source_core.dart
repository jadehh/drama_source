/*
 * @Author: jadehh
 * @Date: 2024-08-19 09:29:52
 * @LastEditTime: 2024-08-19 16:40:51
 * @LastEditors: jadehh
 * @Description: drama_source_core
 * @FilePath: \drama_source\drama_source_core\lib\drama_source_core.dart
 * 
 */
library drama_source_core;

import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/model/prefers.dart';
import 'package:drama_source_core/src/service/db_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
export 'src/common/core_log.dart';
export 'src/model/setting.dart';
export 'src/app/controller/app_setting_controller.dart';
export 'src/log.dart';
export 'src/utils/utils.dart';
export 'src/utils/file_util.dart';
export 'src/app/controller/app_focus_node.dart';
export 'src/event/event.dart';
export 'src/event/refresh_event.dart';
export 'src/model/local.dart';


class DramaSourceCore {

 static Future initServices() async {
  // Hive.registerAdapter(FollowUserAdapter());
  // Hive.registerAdapter(HistoryAdapter());

  //包信息
  Utils.packageInfo = await PackageInfo.fromPlatform();
  //本地存储
  Log.d("Init LocalStorage Service");
  await Get.put(Prefers()).init();
  await Get.put(DBService()).init();

  //初始化设置控制器
  await Get.put(AppSettingsController());
  initCoreLog();
}


static void initCoreLog() {
  //日志信息
  CoreLog.enableLog = !kReleaseMode || AppSettingsController.instance.logEnable.value;
  CoreLog.requestLogType = RequestLogType.short;
  CoreLog.onPrintLog = (level, msg) {
    switch (level) {
      case Level.debug:
        Log.d(msg);
        break;
      case Level.error:
        Log.e(msg, StackTrace.current);
        break;
      case Level.info:
        Log.i(msg);
        break;
      case Level.warning:
        Log.w(msg);
        break;
      default:
        Log.logPrint(msg);
    }
  };
}
}