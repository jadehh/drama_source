/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-08-19 16:34:20
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\modules\vod\views\vod_view.dart
 * 
 */
import 'package:drama_source_app/app/modules/vod/controllers/vod_controller.dart';
import 'package:drama_source_app/app/modules/vod/dialog/site_dialog.dart';
import 'package:drama_source_app/app/modules/vod/views/search_view.dart';
import 'package:drama_source_app/app/modules/vod/views/vod_tab_view.dart';
import 'package:drama_source_app/widgets/icon_button/base_icon_button.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodView extends GetView<VodController> {
  const VodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
           SizedBox(
            height: 60.0, // 设置高度
            child: Row(
              children: [
                BaseIconButton(Icons.donut_large_outlined, (){
                  if(VodConfig.get().getSites().length > 0) {
                    Get.dialog(SiteDialog(controller.getSiteCallBack()));
                  }
                }),
                Expanded(child:const SearchView()),
                BaseIconButton(Icons.star, (){}),
                BaseIconButton(Icons.history, (){})
              ],
            ),
          ),
          Obx( ()=> Visibility(
              child: Expanded(
                  child: Center(
                      child: IconButton(
                          onPressed: () async{
                           await controller.homeContent();
                          },
                          icon: const Icon(
                            Icons.refresh,
                            size: 48,
                            color: Colors.white,
                          )))),
              visible: controller.retryVisible.value)),
          Obx(()=>Visibility(child: Expanded(child: Center(child: CircularProgressIndicator(color: Colors.white,))),
            visible: controller.progressVisible.value,)),
          Obx(()=>Visibility(child: Expanded(child: VodTabView(controller.result.value,controller))
              ,visible: controller.vodVisable.value)),
        ]),
        Obx(()=>Visibility(child: Positioned(
          right: 32.0,
          bottom: 16.0,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () async{
              await controller.homeContent();
            },
            child: Icon(Icons.link,color: Colors.white,),
          ),
        ),visible: controller.linkVisable.value)),
      ],
    );
  }
}
