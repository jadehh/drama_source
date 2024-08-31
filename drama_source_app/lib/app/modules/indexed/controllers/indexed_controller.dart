/*
 * @Author: jadehh
 * @Date: 2024-08-19 13:47:14
 * @LastEditTime: 2024-08-20 11:23:19
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\modules\indexed\controllers\indexed_controller.dart
 * 
 */

import 'dart:io';

import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/constant.dart';
import 'package:drama_source_app/app/modules/setting/controllers/setting_controller.dart';
import 'package:drama_source_app/app/modules/setting/views/setting_view.dart';
import 'package:drama_source_app/app/modules/vod/controllers/vod_controller.dart';
import 'package:drama_source_app/app/modules/vod/views/vod_view.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:get/get.dart';

class IndexedController extends GetxController {
  RxList<HomePageItem> items = RxList<HomePageItem>([]);

  var index = 0.obs;
  RxList<Widget> pages = RxList<Widget>([
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ]);

  void setIndex(int i) {
    if (pages[i] is SizedBox) {
      switch (items[i].index) {
        case 0:
          Get.put(VodController());
          pages[i] = const VodView();
          break;
        case 1:
          // Get.put(FollowUserController());
          // pages[i] = const FollowUserPage();
          break;
        case 2:
          Get.put(SettingController());
          pages[i] = const SettingView();
          break;
        // case 3:
        //   pages[i] = const MinePage();
        //   break;
        default:
      }
    } else {
      if (index.value == i) {
        RefreshEvent.buttom();
      }
    }

    index.value = i;
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, showFirstRun);
    items.value = AppSettingsController.instance.homeSort
        .map((key) => Constant.allHomePages[key]!)
        .toList();
    setIndex(0);
    _initConfig();
  }

  void showFirstRun() async {
    var settingsController = Get.find<AppSettingsController>();
    if (settingsController.firstRun) {
      await settingsController.setNoFirstRun();
      // await Utils.showStatement(AppStyle.edgeInsetsA12);
      // Utils.checkUpdate(AppStyle.edgeInsetsA12,AppStyle.hGap32);
    } else {
      // Utils.checkUpdate(AppStyle.edgeInsetsA12,AppStyle.hGap32);
    }
  }

  void _initConfig() async {
    await WallConfig.get().init();
    await (await LiveConfig.get().init()).load();
    await (await VodConfig.get().init()).load(callback: _getCallback(), cache: true);
  }

  Callback _getCallback() {
    Callback callBack = Callback(success, error);
    return callBack;
  }

  void success({String? message}) {
    RefreshEvent.config();
    RefreshEvent.video();
  }

  void error(String message) {
    RefreshEvent.config();
    StateEvent.empty();
    if (message.isNotEmpty) SmartDialog.showToast(message);
  }

  List<Widget> setButtomView() {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(Tooltip(
        message: items[i].title,
        child: IconButton(
            onPressed: () {
              setIndex(i);
            },
            icon: Icon(items[i].iconData)),
      ));
    }
    return widgets;
  }

  Visibility? getNavNuttomView(orientation) {
    if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      return null;
    } else {
      return Visibility(
        visible: orientation == Orientation.portrait,
        child: Obx(
          () => NavigationBar(
            selectedIndex: index.value,
            onDestinationSelected: setIndex,
            height: 56,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: items
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(item.iconData),
                    label: item.title,
                  ),
                )
                .toList(),
          ),
        ),
      );
    }
  }

  Visibility getNavEvent(orientation) {
    return Visibility(
      visible: orientation == Orientation.landscape,
      child: Obx(
        () => NavigationRail(
          selectedIndex: index.value,
          onDestinationSelected: setIndex,
          labelType: NavigationRailLabelType.none,
          destinations: items
              .map(
                (item) => NavigationRailDestination(
                  icon: Icon(item.iconData),
                  label: Text(item.title),
                  padding: AppStyle.edgeInsetsV8,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget getBodyWidgets(orientation) {
    List<Widget> widgets = [
      Expanded(
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              border: Border(
                left: orientation == Orientation.landscape
                    ? BorderSide(
                        color: Colors.grey.withOpacity(.2),
                        width: 1,
                      )
                    : BorderSide.none,
              ),
            ),
            child: IndexedStack(
              index: index.value,
              children: pages,
            ),
          ),
        ),
      ),
    ];
    if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      widgets.add(Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: setButtomView(),
            ),
          )));
      return Column(children: widgets);
    }else{
      widgets.insert(0,    getNavEvent(orientation));
      return Row(children: widgets);
    }
  }
}
