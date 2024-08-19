/*
 * @File     : appbar_view
 * @Author   : jade
 * @Date     : 2024/07/11 07:43:36
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_app/app/modules/vod/views/search_view.dart';
import 'package:drama_source_app/widgets/icon_button/base_icon_button.dart';
import 'package:flutter/material.dart';
 
class AppBarView extends StatelessWidget {
  const AppBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          BaseIconButton(Icons.donut_large_outlined, (){}),
          Expanded(child:const SearchView()),
          BaseIconButton(Icons.star, (){}),
          BaseIconButton(Icons.history, (){})
        ],
      );
  }
}
