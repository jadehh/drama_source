/*
 * @File     : filter_controller.dart
 * @Author   : jade
 * @Date     : 2024/9/30 12:59
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/drama_source_core.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final List<Filter> filter;
  final FilterCallBack callBack;
  final List<List<AppFocusNode>> focusNode = [];
  FilterController(this.filter,this.callBack);

  @override
  void onInit() {
    for(var ele in filter){
      List<AppFocusNode> ele_focusNode = [];
      for (var value in ele.getValue()){
        var appFucus = AppFocusNode();
        appFucus.isFoucsed.value = value.j_activated ?? false;
        ele_focusNode.add(appFucus);
      }
      focusNode.add(ele_focusNode);
    }
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
  void setFilter(row,col) {
    Map<String,String> extend = {};
    for(var value in filter[row].getValue()) value.setActivated(activated: false);
    if (focusNode[row][col].isFoucsed.value){
      focusNode[row][col].isFoucsed.value = false;
    }else{
      filter[row].getValue()[col].setActivated(activated: true);
    }
    for(var i=0;i<filter.length;i++){
      for(var j=0;j<filter[i].getValue().length;j++){
        focusNode[i][j].isFoucsed.value = filter[i].getValue()[j].j_activated ?? false;
        if(focusNode[i][j].isFoucsed.value){
          extend[filter[i].getKey()] = filter[i].getValue()[j].getV();
        }
      }
    }
    print("刷新分类页面");
    callBack.refresh(extend);
  }
}
