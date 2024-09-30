/*
 * @File     : filter_dialog.dart
 * @Author   : jade
 * @Date     : 2024/9/30 9:38
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/modules/vod/controllers/filter_controller.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends GetView<FilterController> {
  final List<Filter> filter;
  final FilterCallBack callBack;
  const FilterDialog(this.filter,this.callBack, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FilterController(filter,callBack),
        builder: (controller) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
              color: Colors.white
            ),
            height: 150,
            child: ListView.builder(
                itemExtent: 50,
                itemCount: controller.filter.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, row) {
                  return Container(
                    padding: AppStyle.edgeInsetsA4,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.filter[row].getValue().length,
                        itemBuilder: (context, col) {
                          return Obx(()=>Container(
                              padding: AppStyle.edgeInsetsA4,
                              child:   OutlinedButton(
                                  focusNode: controller.focusNode[row][col],
                                  style: AppStyle.filterOutLinedButtonStyle(controller.focusNode[row][col].isFoucsed.value),
                                  child: Text(controller.filter[row].getValue()[col].getN()),
                                  onPressed: () {
                                    controller.setFilter(row,col);
                                  }) ));
                        }),
                  );
                })));
  }
}
