/*
 * @File     : appbar_view
 * @Author   : jade
 * @Date     : 2024/07/11 07:43:36
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:dramasource/event/focus_state.dart';
import 'package:dramasource/page/base/views/base_icon_button.dart';
import 'package:dramasource/page/vod/views/search_view.dart';
import 'package:flutter/material.dart';
 
class AppBarView extends StatelessWidget {
  const AppBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          FocusState.instance.focusWidget(BaseIconButton(Icons.donut_large_outlined, (){})),
          Expanded(child: FocusState.instance.focusWidget( const SearchView())),
          FocusState.instance.focusWidget(BaseIconButton(Icons.star, (){})),
          FocusState.instance.focusWidget(BaseIconButton(Icons.history, (){}))
        ],
      );
  }
}
