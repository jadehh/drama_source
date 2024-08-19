/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:13:28
 * @LastEditTime: 2024-08-19 17:13:04
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\model\prefers.dart
 * 
 */
import 'package:drama_source_core/drama_source_core.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Prefers extends GetxService {
  static Prefers get instance => Get.find<Prefers>();

  // 壁纸
  static const String kWall = "Wall";

  /// 首次运行
  static const String kFirstRun = "FirstRun";

  /// 缩放模式
  static const String kPlayerScaleMode = "ScaleMode";

  /// DEBUG模式
  static const String kLogEnable = "LogEnabel";

  // 语言
  static const String kLanguage = "Language";

  // 版本
  static const String kVersion = "Version";

  // 构建名
  static const String kBuildName = "BuildName";


  /// 显示模式
  /// * [0] 跟随系统
  /// * [1] 浅色模式
  /// * [2] 深色模式
  static const String kThemeMode = "ThemeMode";



  late Box settingsBox;

  Future init() async {
    settingsBox = await Hive.openBox(
      "LocalStorage",
    );
  }

  T getValue<T>(dynamic key, T defaultValue) {
    try {
      var value = settingsBox.get(key, defaultValue: defaultValue) as T;
      Log.d("Get LocalStorage：$key\r\n$value");
      return value;
    } catch (e) {
      Log.logPrint(e);
      return defaultValue;
    }
  }

  Future setValue<T>(dynamic key, T value) async {
    Log.d("Set LocalStorage：$key\r\n$value");
    return await settingsBox.put(key, value);
  }

  Future removeValue<T>(dynamic key) async {
    Log.d("Remove LocalStorage：$key");
    return await settingsBox.delete(key);
  }

}



