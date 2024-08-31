/*
 * @File     : vod_controller.dart
 * @Author   : jade
 * @Date     : 2024/08/09 02:10:44
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:async';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:get/get.dart';

class VodController extends GetxController {
  final retryVisible = false.obs;
  final progressVisible = false.obs;
  late final SiteViewModel mViewModel;
  StreamSubscription<dynamic>? streamSubscription;

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
  }

     homeContent() async {
        setSiteText();
        showProgress();
        // _setFabVisible(0);
        // mAdapter.clear();
        await mViewModel.homeContent();
        // mBinding.pager.setAdapter(new PageAdapter(getChildFragmentManager()));
    }

    void setSiteText() {
        String site = getSite().getName();
        Log.i("首页信息:${site.toString()}");
    }
    Site getSite() {
        return VodConfig.get().getHome();
    }

    showProgress(){
        retryVisible.value = false;
        progressVisible.value = false;
    }
}
