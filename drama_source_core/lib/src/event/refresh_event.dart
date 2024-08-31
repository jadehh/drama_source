/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:18:32
 * @LastEditTime: 2024-08-21 17:25:46
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\event\refresh_event.dart
 * 
 */

import 'package:drama_source_core/src/event/event.dart';

class RefreshEvent {
  static String kBottomNavigationBarClicked = "BottomNavigationBarClicked";
  static String kRefresh = "refresh";

  static void wall() {
    EventBus.instance.emit(kRefresh, RefreshType.WALL);
  }

  static void buttom() {
    EventBus.instance.emit(kBottomNavigationBarClicked, 0);
  }

  static void video() {
    EventBus.instance.emit(kRefresh, RefreshType.VIDEO);
  }

  static void config() {
    EventBus.instance.emit(kRefresh, RefreshType.CONFIG);
  }

  static void keep() {
    EventBus.instance.emit(kRefresh, RefreshType.KEEP);
  }

}

enum RefreshType {
  CONFIG,
  IMAGE,
  VIDEO,
  HISTORY,
  KEEP,
  SIZE,
  WALL,
  DETAIL,
  PLAYER,
  SUBTITLE,
  DANMAKU
}
