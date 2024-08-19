/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:12:20
 * @LastEditTime: 2024-08-19 17:10:04
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\model\setting.dart
 * 
 */


import 'package:drama_source_core/src/model/prefers.dart';

class Setting {
  // 设置主题壁纸
  static void setWall(int wall) {
    Prefers.instance.setValue(Prefers.kWall, wall);
  }

  // 获取主题壁纸(有默认值)
  static int getWallByDefault(int defaultValue) {
    return Prefers.instance.getValue(Prefers.kWall, defaultValue);
  }

  // 获取主题壁纸
  static int getWall() {
    return Prefers.instance.getValue(Prefers.kWall,0);
  }

  // 设置主题
  static void setTheme(int themeMode) {
    Prefers.instance.setValue(Prefers.kThemeMode, themeMode);
  }

  // 获取主题
  static int getTheme() {
    return Prefers.instance.getValue(Prefers.kThemeMode,0);
  }

  // 设置是否首次运行
  static void setFirstRun(){
     Prefers.instance.setValue(Prefers.kFirstRun,false);
  }

  // 获取是否首次运行
  static bool getFirstRun(bool value){
    return Prefers.instance.getValue(Prefers.kFirstRun,value);
  }

  // 设置播放界面缩放Mode
  static void setScaleMode(){
     Prefers.instance.setValue(Prefers.kPlayerScaleMode, 0);
  }

  // 获取播放界面缩放Mode
  static int getScaleModel(){
    return Prefers.instance.getValue(Prefers.kPlayerScaleMode,0);
  }

  // 设置是否启用开发者日志
  static void setLogEnable(bool value){
     Prefers.instance.setValue(Prefers.kLogEnable, false);
  }


  // 获取是否启用开发者日志
  static bool getLogEnable(){
    return Prefers.instance.getValue(Prefers.kLogEnable,false);
  }


  // 设置语言
  static void setLanguage(int language) {
    Prefers.instance.setValue(Prefers.kLanguage, language);
  }

  // 获取语言
  static int getLanguage() {
    return Prefers.instance.getValue(Prefers.kLanguage,0);
  }

  // 设置版本
  static void setVersion(String version) {
    Prefers.instance.setValue(Prefers.kVersion, version);
  }

  // 获取版本
  static String getVersion() {
    return Prefers.instance.getValue(Prefers.kVersion,"");
  }

  // 设置构建名
  static void setBuildName(String buildName) {
    Prefers.instance.setValue(Prefers.kBuildName, buildName);
  }

  // 获取构建名
  static String getBuildName() {
    return Prefers.instance.getValue(Prefers.kBuildName,"");
  }
}
