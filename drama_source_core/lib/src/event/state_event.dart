/*
 * @File     : state_event.dart
 * @Author   : jade
 * @Date     : 2024/8/26 下午9:52
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

 import 'package:drama_source_core/src/event/event.dart';

class StateEvent {

     static String kStateRefresh = "stateRefresh";

     static void empty() {
      EventBus.instance.emit(kStateRefresh, StateType.EMPTY);
    }

     static void progress() {
      EventBus.instance.emit(kStateRefresh, StateType.PROGRESS);
    }

     static void content() {
      EventBus.instance.emit(kStateRefresh, StateType.CONTENT);
    }

}

enum StateType {
        EMPTY, PROGRESS, CONTENT
}