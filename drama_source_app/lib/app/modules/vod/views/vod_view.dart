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
import 'package:drama_source_app/app/modules/vod/views/appbar_view.dart';
import 'package:drama_source_app/app/modules/vod/views/vod_tab_view.dart';
import 'package:drama_source_app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VodView extends GetView<VodController> {
  const VodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 60.0, // 设置高度
            child: AppBarView(),
          ),
          Obx( ()=> Visibility(
              child: Expanded(
                  child: Center(
                      child: IconButton(
                          onPressed: () {
                            controller.progressVisible.value = ! controller.progressVisible.value;
                            controller.retryVisible.value = !controller.retryVisible.value ;
                          },
                          icon: const Icon(
                            Icons.refresh,
                            size: 56,
                            color: Colors.white,
                          )))),
              visible: controller.retryVisible.value)),
          Obx(()=>Visibility(child: Expanded(child: Center(child: CircularProgressIndicator(color: Colors.white,))),visible: controller.progressVisible.value,)),
          // const Expanded(child: VodTabView(20)),
        ]),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () async{
              await controller.homeContent();
              controller.progressVisible.value = ! controller.progressVisible.value;
            },
            child: Icon(Icons.link,color: Colors.white,),
          ),
        ),
      ],
    );
  }
}
