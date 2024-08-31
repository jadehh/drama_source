/*
 * @Author: jadehh
 * @Date: 2024-08-19 09:29:52
 * @LastEditTime: 2024-08-22 09:28:35
 * @LastEditors: jadehh
 * @Description: drama_source_core
 * @FilePath: \drama_source\drama_source_core\lib\drama_source_core.dart
 * 
 */
library drama_source_core;

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_core/src/service/db_service.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
export 'src/model/setting.dart';
export 'src/app/controller/app_setting_controller.dart';
export 'src/utils/utils.dart';
export 'src/utils/file_util.dart';
export 'src/app/controller/app_focus_node.dart';
export 'src/event/event.dart';
export 'src/event/refresh_event.dart';
export 'src/event/state_event.dart';
export 'src/model/language/local.dart';
export "src/api/config/vod_config.dart";
export "src/api/config/live_config.dart";
export 'src/api/config/wall_config.dart';
export 'src/utils/language_util.dart';
export 'src/utils/url_util.dart';
export 'src/utils/notify.dart';
export 'src/impl/call_back.dart';
export "src/api/bean/config.dart";
export 'src/api/bean/rule.dart';
export 'src/api/bean/ext.dart';
export 'src/api/bean/site.dart';
export 'src/model/site_view_model.dart';

class DramaSourceCore {
  static Future initServices() async {
    // Hive.registerAdapter(FollowUserAdapter());
    // Hive.registerAdapter(HistoryAdapter());



    //包信息
    Utils.packageInfo = await PackageInfo.fromPlatform();


    //本地存储
    Log.d("Init LocalStorage Service");
    await Get.put(Prefers()).init();
    //初始化路径
    await initPath();
    await Get.put(DBService()).init();
    await AppDatabase.instance.init();
    //初始化设置控制器
    await Get.put(AppSettingsController());

    //配置文件初始化
    // await initConfig();


  }
  
  static Future initPath() async{
    Log.i("路径初始化");
    await Setting.putApplicationSupportDirectory((await getApplicationSupportDirectory()).absolute.path);
    Log.i("ApplicationSupportDirectory:${Setting.getApplicationSupportDirectory()}");
    await Setting.putApplicationCacheDirectory((await getApplicationCacheDirectory()).absolute.path);
    Log.i("ApplicationCacheDirectory:${Setting.getApplicationCacheDirectory()}");
    await Setting.putApplicationDocumentsDirectory((await getApplicationDocumentsDirectory()).absolute.path);
    Log.i("ApplicationDocumentsDirectory:${Setting.getApplicationDocumentsDirectory()}");
    await Setting.putDownloadsDirectory((await getDownloadsDirectory())?.absolute.path);
    Log.i("DownloadsDirectory:${Setting.getDownloadsDirectory()}");
    // await Setting.putLibraryDirectory((await getLibraryDirectory()).absolute.path);
    // Log.i("LibraryDirectory:${Setting.getLibraryDirectory()}");
    // await Setting.putTemporaryDirectory((await getTemporaryDirectory()).absolute.path);
    // Log.i("TemporaryDirectory:${Setting.getTemporaryDirectory()}");
    // await Setting.putExternalStorageDirectory((await getExternalStorageDirectory())!.absolute.path);
    // Log.i("ExternalStorageDirectory:${Setting.getExternalStorageDirectory()}");
    // await Setting.putExternalCacheDirectories((await getExternalCacheDirectories()));
    // await Setting.putExternalStorageDirectories((await getExternalStorageDirectories()));
  }



}
