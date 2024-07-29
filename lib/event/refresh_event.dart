/*
 * @File     : refresh_event.dart
 * @Author   : jade
 * @Date     : 2024/07/18 05:21:23
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:dramasource/event/event.dart';
import 'package:flutter/foundation.dart';

class RefreshEvent {
  late Type type;
  late String path;

  void config() {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByType(Type.config));
  }

  void image() {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByType(Type.image));
  }

  void video() {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByType(Type.video));
  }

  void history() {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByType(Type.history));
  }

  void keep() {
    EventBusUtil.instance.getDefaultEvent().fire(refreshEventByType(Type.keep));
  }

  void size() {
    EventBusUtil.instance.getDefaultEvent().fire(refreshEventByType(Type.size));
  }

  void wall() {
    if (kDebugMode) {
      print("通知刷新背景图片");
    }
    EventBusUtil.instance.getDefaultEvent().fire(refreshEventByType(Type.wall));
  }

  void detail() {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByType(Type.detail));
  }

  void player() {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByType(Type.player));
  }
  void subtitle(String path) {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByPath(Type.subtitle, path));
  }

  void danmaku(String path) {
    EventBusUtil.instance
        .getDefaultEvent()
        .fire(refreshEventByPath(Type.danmaku, path));
  }

  RefreshEvent refreshEventByType(Type type) {
    this.type = type;
    return this;
  }

  RefreshEvent refreshEventByPath(Type type, String path) {
    this.type = type;
    this.path = path;
    return this;
  }

  Type getType() {
    return type;
  }

  String getPath() {
    return path;
  }
}

enum Type {
  config,
  image,
  video,
  history,
  keep,
  size,
  wall,
  detail,
  player,
  subtitle,
  danmaku
}
