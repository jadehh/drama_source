import 'dart:io';

import 'package:drama_source_app/app/modules/indexed/controllers/base_controller.dart';
import 'package:drama_source_app/widgets/status/app_empty_widget.dart';
import 'package:drama_source_app/widgets/status/app_error_widget.dart';
import 'package:drama_source_app/widgets/status/app_loadding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class PageGridView extends StatelessWidget {
  final BasePageController pageController;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets? padding;
  final bool firstRefresh;
  final Function()? onLoginSuccess;
  final bool showPageLoadding;
  final double crossAxisSpacing, mainAxisSpacing;
  final int crossAxisCount;
  final bool showPCRefreshButton;
  const PageGridView({
    required this.itemBuilder,
    required this.pageController,
    this.padding,
    this.firstRefresh = false,
    this.showPageLoadding = false,
    this.onLoginSuccess,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.showPCRefreshButton = true,
    required this.crossAxisCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: MaterialHeader(
              completeDuration: const Duration(milliseconds: 400),
            ),
            footer: MaterialFooter(
              completeDuration: const Duration(milliseconds: 400),
            ),
            scrollController: pageController.scrollController,
            controller: pageController.easyRefreshController,
            onLoad: pageController.loadData,
            onRefresh: pageController.refreshData,
            firstRefresh: firstRefresh,
            child: MasonryGridView.count(
              padding: padding,
              itemCount: pageController.list.length,
              itemBuilder: itemBuilder,
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ),
          ),
          Offstage(
            offstage: !pageController.pageEmpty.value,
            child: AppEmptyWidget(
              onRefresh: () => pageController.refreshData(),
            ),
          ),
          Offstage(
            offstage: !(showPageLoadding && pageController.pageLoadding.value),
            child: const AppLoaddingWidget(),
          ),
          Offstage(
            offstage: !pageController.pageError.value,
            child: AppErrorWidget(
              errorMsg: pageController.errorMsg.value,
              onRefresh: () => pageController.refreshData(),
            ),
          ),
        ],
      ),
    );
  }
}
