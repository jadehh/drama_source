/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:18:32
 * @LastEditTime: 2024-08-19 17:26:53
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\event\refresh_event.dart
 * 
 */

import 'package:drama_source_core/src/event/event.dart';
import 'package:drama_source_core/src/model/prefers.dart';

class RefreshEvent {
  
  void wall() {
    EventBus.instance.emit(Prefers.kWall,0);
  }

  void buttom(){
    EventBus.instance.emit(Prefers.kBottomNavigationBarClicked,0);
  }
}

