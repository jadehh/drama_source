/*
 * @Author: jadehh
 * @Date: 2024-07-16 09:17:47
 * @LastEditTime: 2024-07-16 15:28:24
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\vod\views\vod_page_view.dart
 * 
 */

import 'package:dramasource/page/vod/controllers/vod_page_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class VodPageView extends GetView<VodPageController> {
  final int pageCount;
  VodPageView(this.pageCount, {super.key});

  final List<Widget> pages = [];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < pageCount; i++) {
      pages.add(PageViewPage(i));
    }
    PageController pageController = PageController(initialPage: 10);
    return SizedBox.expand(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return pages[index];
        },
        onPageChanged: (int index){
        if (kDebugMode) {
          print("当前的页面是 $index");
        }
        ///滑动PageView时，对应切换选择高亮的标签
      },
      physics: const BouncingScrollPhysics(),
      ),
    );
  }
}

class PageViewPage extends StatelessWidget {
  final int index;

  const PageViewPage(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.red,
      child: Text(
        'Page ${index + 1}',
      ),
    );
  }
}
