/*
 * @Author: jadehh
 * @Date: 2024-07-17 14:07:14
 * @LastEditTime: 2024-07-18 10:57:21
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\core\model\setting.dart
 * 
 */

import 'package:dramasource/core/model/prefers.dart';

class Setting {
  static void setWall(int wall) {
    Prefers.instance.set("wall", wall);
  }

  static int getWall() {
    return Prefers.instance.getInt("wall");
  }

  static void setLanguage(int language) {
    Prefers.instance.set("language", language);
  }

  static int getLanguage() {
    return Prefers.instance.getInt("language");
  }

  static void setVersion(String version) {
    Prefers.instance.set("version", version);
  }

  static String getVersion() {
    return Prefers.instance.getString("version");
  }

  static void setBuildName(String buildName) {
    Prefers.instance.set("buildName", buildName);
  }

  static String getBuildName() {
    return Prefers.instance.getString("buildName");
  }
}
