/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:17:36
 * @LastEditTime: 2024-08-19 11:17:40
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\config\wall_config.dart
 * 
 */


import 'package:drama_source_core/src/event/refresh_event.dart';
import 'package:drama_source_core/src/model/setting.dart';

class WallConfig {
  static final WallConfig _instance = WallConfig._internal();
  static WallConfig get instance => _instance;

  factory WallConfig() {
    return _instance;
  }
  WallConfig._internal();

  WallConfig get() {
    return instance;
  }

  static void refresh(int index) {
    Setting.setWall(index);
    RefreshEvent().wall();
  }
}
