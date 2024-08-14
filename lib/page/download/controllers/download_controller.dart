/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-08-13 09:14:49
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\download\controllers\download_controller.dart
 * 
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

class DownloadController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  bool _loading = false;

  FocusNode focusNodeB0 = FocusNode();
  FocusNode focusNodeB1 = FocusNode();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    tabController = TabController(length: 2, vsync: this);
    focusNodeB0.addListener(() {
      if (focusNodeB0.hasFocus) {
        tabController.animateTo(1);
      }
    });

    focusNodeB1.addListener(() {
      if (focusNodeB1.hasFocus) {
        tabController.animateTo(1);
      }
    });
  }

  void _onScroll() {
    if (kDebugMode) {
      print(sprintf('position %s, max postion %s', [
        scrollController.position.pixels.toInt(),
        scrollController.position.maxScrollExtent.toInt()
      ]));
    }
    if (scrollController.position.pixels.toInt() ==
            scrollController.position.maxScrollExtent.toInt() - 80 &&
        !_loading) {
      refreshController.requestLoading();
      _loading = true;
    }
  }
}
