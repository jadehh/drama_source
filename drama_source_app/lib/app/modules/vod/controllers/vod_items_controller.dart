/*
 * @File     : vod_items_controller.dart
 * @Author   : jade
 * @Date     : 2024/08/12 01:58:10
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:drama_source_core/drama_source_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VodItemsController extends GetxController{
   late bool _isLoading;
  late List<Vod> vodList;
  late RefreshController refreshController;
  VodItemsController(List<Vod> _vodList) {
    vodList = _vodList;
    _isLoading = false;
    refreshController  = RefreshController(initialRefresh: false);
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onRefresh() async {
      await Future.delayed(const Duration(seconds: 2));
      refreshController.refreshCompleted();
      update(['vod_items']);
  }

  Future<void> onLoading() async {
    if (!_isLoading) {
      await Future.delayed(const Duration(seconds: 2));
      refreshController.loadComplete();
      update(['vod_items']);
      _isLoading = false;
    } else {
      refreshController.loadNoData();
    }
  }

}



