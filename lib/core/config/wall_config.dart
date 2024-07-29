/*
 * @File     : wall_config.dart
 * @Author   : jade
 * @Date     : 2024/07/18 11:04:02
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/event/refresh_event.dart';

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
