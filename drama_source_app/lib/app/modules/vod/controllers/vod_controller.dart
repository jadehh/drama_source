/*
 * @File     : vod_controller.dart
 * @Author   : jade
 * @Date     : 2024/08/09 02:10:44
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:async';
import 'package:drama_source_app/app/modules/vod/views/vod_page_view.dart';
import 'package:drama_source_app/widgets/button/highlight_button.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodController extends GetxController with GetTickerProviderStateMixin {
  final retryVisible = false.obs;
  final progressVisible = false.obs;
  final Rx<Result> result = Result().obs;
  late final SiteViewModel mViewModel;
  StreamSubscription<dynamic>? streamSubscription;

  final List<Widget> items = [];
  final List<Widget> tabs = [];
  late TabController tabController;
  final tabIndex = 0.obs;
  late final List<AppFocusNode> _focusList = [];

  @override
  void onInit() {
    super.onInit();
    streamSubscription = EventBus.instance.listen(
      RefreshEvent.kRefresh,
      (index) async {
        switch (index) {
          case RefreshType.VIDEO:
          case RefreshType.SIZE:
            await homeContent();
            break;
          case RefreshType.CONFIG:
            Log.d("设置Logo");
            break;
        }
      },
    );
    mViewModel = SiteViewModel();
    initTableController();
  }

  void initTableController(){
    if (result.value.getClass().length  != 0){
      tabController = TabController(length: this.result.value.getClass().length + 1 , vsync: this);
    }else{
      tabController = TabController(length: this.result.value.getClass().length , vsync: this);
    }
    tabController.animation?.addListener(() {
      var currentIndex = (tabController.animation?.value ?? 0).round();
      if (tabIndex.value == currentIndex) {
        return;
      }
      tabIndex.value = currentIndex;
      _focusList[currentIndex].requestFocus();
    });
  }

  homeContent() async {
    setSiteText();
    showProgress();
    // _setFabVisible(0);
    // mAdapter.clear();

    Future.delayed(Duration(seconds: 5), () async {
      result.value = await mViewModel.homeContent();
      setAdapter();
    });
    // mBinding.pager.setAdapter(new PageAdapter(getChildFragmentManager()));

  }

  void setSiteText() {
    String site = getSite().getName();
    Log.i("首页信息:${site.toString()}");
  }

  Site getSite() {
    return VodConfig.get().getHome();
  }

  void setAdapter() {
    initTabsView();
    hideProgress();
    checkRetry();
  }

  void initTabsView() {
    if (tabController.length != this.result.value.getClass().length){
      tabController.dispose();
      initTableController();
    }
    clear();

    var classes = result.value.getClass();
    classes.insert(0, _home());
    for (int i = 0; i < result.value.getClass().length; i++) {
      AppFocusNode appFocusNode = AppFocusNode();
      _focusList.add(appFocusNode);
      // tabs.add(TypeView(title: "V$i", index: tabIndex.value, tabController: tabController));
      tabs.add(Obx(() => HighlightButton(
            focusNode: appFocusNode,
            text: result.value.getClass()[i].getTypeName(),
            selected: tabIndex.value == i,
            onTap: () {
              tabController.animateTo(i);
            },
          )));
      items.add(VodPageView(list:result.value.getList(),id: result.value.getClass()[i].getTypeId()));
    }
  }

  void checkRetry() {
    retryVisible.value = (result.value.getClass().length == 0 ? true : false);
  }

  showProgress() {
    retryVisible.value = false;
    progressVisible.value = true;
  }

  void hideProgress() {
    progressVisible.value = false;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void clear(){
    tabIndex.value = 0;
    items.clear();
    tabs.clear();
    _focusList.clear();
  }
   KClass _home() {
    KClass type = new KClass();
    type.setTypeName(Local.vod_home);
    type.setTypeId("home");
    return type;
  }
}
