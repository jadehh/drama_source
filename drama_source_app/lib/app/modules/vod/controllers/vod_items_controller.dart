/*
 * @File     : vod_items_controller.dart
 * @Author   : jade
 * @Date     : 2024/08/12 01:58:10
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VodItemsController extends GetxController{
   late bool _isLoading;
  late int _currentItemCount;
  late List<String> items;
  late RefreshController refreshController;
  VodItemsController() {
    _currentItemCount = 50;
    _isLoading = false;
    items = List.generate(_currentItemCount, (i) => "Item ${i + 1}");
    refreshController  = RefreshController(initialRefresh: false);
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onRefresh() async {
      await Future.delayed(const Duration(seconds: 2));
      items = List.generate(_currentItemCount, (i) => "Refreshed Item ${i + 1}");
      refreshController.refreshCompleted();
      update(['vod_items']);
  }

  Future<void> onLoading() async {
    if (!_isLoading) {
      await Future.delayed(const Duration(seconds: 2));
      items.addAll(List.generate(5, (i) => 'Item ${i + items.length + 1}'));
      refreshController.loadComplete();
      update(['vod_items']);
      _isLoading = false;
    } else {
      refreshController.loadNoData();
    }
  }

}



