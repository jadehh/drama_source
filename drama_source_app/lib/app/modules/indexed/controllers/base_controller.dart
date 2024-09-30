import 'dart:async';

import 'package:drama_source_log/drama_source_log.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  /// 加载中，更新页面
  var pageLoadding = false.obs;

  /// 加载中,不会更新页面
  var loadding = false;

  /// 空白页面
  var pageEmpty = false.obs;

  /// 页面错误
  var pageError = false.obs;

  /// 未登录
  var notLogin = false.obs;

  /// 错误信息
  var errorMsg = "".obs;

  /// 显示错误
  /// * [msg] 错误信息
  /// * [showPageError] 显示页面错误
  /// * 只在第一页加载错误时showPageError=true，后续页加载错误时使用Toast弹出通知
  void handleError(Object exception, {bool showPageError = false}) {
    Log.e(exception.toString(), StackTrace.current);
    var msg = exceptionToString(exception);

    if (showPageError) {
      pageError.value = true;
      errorMsg.value = msg;
    } else {
      SmartDialog.showToast(exceptionToString(msg));
    }
  }

  String exceptionToString(Object exception) {
    return exception.toString().replaceAll("Exception:", "");
  }

  void onLogin() {}
  void onLogout() {}
}

class BasePageController<T> extends BaseController {
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  late String typeId;

  int currentPage = 1;
  int count = 0;
  int maxPage = 0;
  int pageSize = 24;
  var canLoadMore = false.obs;
  var list = <T>[].obs;

  BasePageController({required this.typeId}){}

  Future refreshData() async {
    currentPage = 1;
    list.value = [];
    await loadData();
  }

  Future loadData() async {
    try {
      if (loadding) return;
      loadding = true;
      pageError.value = false;
      pageEmpty.value = false;
      notLogin.value = false;
      pageLoadding.value = currentPage == 1;
      var result;
      if (typeId == "home" ) {
        if (currentPage == 1){
          result = await getHomeData();
          easyRefreshController.finishLoad(noMore: true);
        }
      }
      else {
        result = await getData(typeId,currentPage, pageSize);
        if (result.isNotEmpty){
            canLoadMore.value = true;
            pageEmpty.value = false;
            currentPage++;
        }else{
          canLoadMore.value = false;
        }
      }
      // 赋值数据
      if (currentPage == 1) {
        list.value = result;
      } else {
        list.addAll(result);
      }

    } catch (e) {
      handleError(e, showPageError: currentPage == 1);
    } finally {
      loadding = false;
      pageLoadding.value = false;
    }
  }

  Future<List<T>> getData(String typeId,int page, int pageSize) async {
    return [];
  }

  Future<List<T>> getHomeData() async {
    return [];
  }

  void scrollToTopOrRefresh() {
    if (scrollController.offset > 0) scrollController.animateTo(0, duration: const Duration(milliseconds: 200),curve: Curves.linear);
     else easyRefreshController.callRefresh();
  }
}
