/*
 * @File     : base_tv_widget.dart
 * @Author   : jade
 * @Date     : 2024/08/12 03:53:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class TVWidget extends StatefulWidget {
  final Widget child;
  final OnFocusChange ? focusChange;
  final Callback onPressed;
  final bool autofocus;
  const TVWidget(
      {required this.child,
      required this.onPressed,
      this.focusChange,
      this.autofocus = false,
      super.key});
  @override
  State<StatefulWidget> createState() {
    return TVWidgetState();
  }
}

typedef OnFocusChange = void Function(bool hasFocus);

class TVWidgetState extends State<TVWidget> {
  late FocusNode _focusNode;
  bool init = false;
  BoxDecoration decoration = BoxDecoration(
      border: Border.all(width: 3, color: Colors.deepOrange),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ));

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (widget.focusChange != null){
        widget.focusChange!(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autofocus && !init) {
      FocusScope.of(context).requestFocus(_focusNode);
      init = true;
    }
    return KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (event) => {
              if (event is KeyDownEvent)
                {
                  switch (event.logicalKey) {
                    LogicalKeyboardKey.arrowLeft => FocusScope.of(context).requestFocus(_focusNode),
                    LogicalKeyboardKey.arrowDown => FocusScope.of(context).focusInDirection(TraversalDirection.down),
                    LogicalKeyboardKey.arrowRight => FocusScope.of(context).focusInDirection(TraversalDirection.right),
                    LogicalKeyboardKey.arrowUp => FocusScope.of(context).focusInDirection(TraversalDirection.up),
                    LogicalKeyboardKey.enter => widget.onPressed,
                    LogicalKeyboardKey() => (),
                  }
                }
            },
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: decoration,
          child: widget.child,
        ));
  }
}
