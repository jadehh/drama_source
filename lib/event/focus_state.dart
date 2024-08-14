/*
 * @File     : focus.dart
 * @Author   : jade
 * @Date     : 2024/08/07 05:00:10
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/material.dart';

class FocusState {
  static final FocusState instance = FocusState._internal();

  factory FocusState() => instance;

  FocusState._internal();

  final FocusScopeNode focusNode = FocusScopeNode();

  FocusScopeNode? hasFocus() {
    focusNode.canRequestFocus = true;
    return focusNode;
  }

  FocusScopeNode? noFocus() {
    focusNode.canRequestFocus = false;
    return focusNode;
  }

  // FocusScope focusWidget(Widget widget){
  //   return FocusScope(node: hasFocus(),child: widget);
  // }

  // FocusScope noFocusWidget(Widget widget){
  //   return FocusScope(node: noFocus(),child: widget);
  // }

  Widget focusWidget(Widget widget){
    return widget;
  }
}
