/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:18:16
 * @LastEditTime: 2024-08-19 17:28:04
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\event\event.dart
 * 
 */

import 'dart:async';

import 'package:drama_source_core/drama_source_core.dart';


/// 全局事件
class EventBus {
  static EventBus? _instance;

  static EventBus get instance {
    _instance ??= EventBus();
    return _instance!;
  }

  final Map<String, StreamController> _streams = {};

  /// 触发事件
  void emit<T>(String name, T data) {
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});
    }
    Log.d("Emit Event：$name\r\n$data");

    _streams[name]!.add(data);
  }

  /// 监听事件
  StreamSubscription<dynamic> listen(String name, Function(dynamic)? onData) {
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});
    }
    return _streams[name]!.stream.listen(onData);
  }
}


