/*
 * @File     : site_controller.dart
 * @Author   : jade
 * @Date     : 2024/9/12 10:49
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SiteController extends GetxController {
  final List<Site> sites = [];
  final List<FocusNode> appFocus = [];
  final int index = VodConfig.getHomeIndex() != null ? VodConfig.getHomeIndex()!:0;
  final ScrollController scrollController = ScrollController();
  final SiteCallback callback;

  SiteController(this.callback);

  @override
  void onInit() {
    super.onInit();
    sites.addAll(VodConfig.get().getSites());
    for (var i = 0;i<VodConfig.get().getSites().length;i++){
      AppFocusNode appFocusNode = AppFocusNode();
      if (i == index){
        appFocusNode.requestFocus();
      }
      appFocus.add(appFocusNode);
    }
  }
  @override
  void onReady() {
    super.onReady();
    _scrollToPosition();
  }



  void _scrollToPosition() {
    // 假设你想要滚动到第20个条目的位置
    // 计算位置
    double scrollTo = index * 50; // 假设每个条目的高度是56.0
    scrollController.animateTo(
      scrollTo,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  setSite(int index)  {
    callback.setSite(sites[index]);
  }
}


