/*
 * @File     : vod_list_controller.dart
 * @Author   : jade
 * @Date     : 2024/9/11 14:12
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_app/app/modules/indexed/controllers/base_controller.dart';
import 'package:drama_source_app/app/modules/vod/dialog/filter_dialog.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class VodListController extends BasePageController<Vod> {
  final EasyRefreshController easyRefreshController = EasyRefreshController();
  final SiteViewModel siteViewModel;
  final  filterVisable = true.obs;
  final List<Filter>? filter;
  Map<String,String> extend = {};
  final String typeId;
  int currentPage = 1;
  var list = <Vod>[].obs;
  VodListController(this.siteViewModel,this.filter, this.typeId) : super(typeId: typeId);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.offset > 0){
        filterVisable.value = false;
      }else if (scrollController.offset == 0){
        filterVisable.value = true;
      }
    });
  }

  @override
  Future<List<Vod>> getData(String typeId, int page, int pageSize) async{
    return (await siteViewModel.categoryContent(typeId, page.toString(), false, extend)).getList();
  }
  @override
  Future<List<Vod>> getHomeData() async{
    return (await siteViewModel.homeContent()).getList();
  }

  showFilterDialog(){
    Get.bottomSheet(FilterDialog(filter!,FilterCallBack(setExtend)));
  }

  setExtend(Map<String,String> _extend){
    extend  = _extend;
    easyRefreshController.callRefresh();
  }
}