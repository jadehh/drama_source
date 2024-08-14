/*
 * @File     : vod_item_view.dart
 * @Author   : jade
 * @Date     : 2024/08/12 02:21:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:dramasource/event/focus_state.dart';
import 'package:dramasource/theme/out_line_button_custom_style.dart';
import 'package:flutter/material.dart';

class VodItemView extends StatelessWidget {
  final String title;
  const VodItemView({required this.title,super.key});
  @override
  Widget build(BuildContext context) {
    return FocusState.instance.focusWidget(OutlinedButton(
        style: OutLineButtonCustomStyle().lightSettingOutlineButtonStyle(),
        onPressed: () {
          
        },
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ));
  }
}




