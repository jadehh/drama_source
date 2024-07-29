/*
 * @File     : appbar_view
 * @Author   : jade
 * @Date     : 2024/07/11 07:43:36
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:dramasource/page/vod/views/search_view.dart';
import 'package:flutter/material.dart';
 
class AppBarView extends StatelessWidget {
  const AppBarView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          IconButton(
              icon: const Icon(Icons.donut_large_outlined),
              onPressed: () {
                // 处理搜索逻辑
              },
            ),
          const Expanded(child: SearchView()),
          IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {
                // 处理搜索逻辑
              },
            ),
          IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                // 处理搜索逻辑
              },
            ),
        ],
      );
  }
}
