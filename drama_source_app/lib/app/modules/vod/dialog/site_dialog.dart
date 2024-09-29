/*
 * @File     : site_dialog.dart
 * @Author   : jade
 * @Date     : 2024/9/12 10:49
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/app/modules/vod/controllers/site_controller.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiteDialog extends GetView<SiteController> {
  final SiteCallback callback;
  const SiteDialog(this.callback,{super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SiteController(callback),
        builder: (controller) => AlertDialog(
              content: Container(
                  width: 300,
                  height: 400,
                  child: ListView.builder(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    itemCount: controller.sites.length,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(4, 8, 8, 4),
                          child: Row(
                            children: [
                              Expanded(child:  OutlinedButton(
                                focusNode: controller.appFocus[index],
                                style: AppStyle.lightOutLineButtonSiteStyle(),
                                onPressed: ()  {
                                  controller.setSite(index);
                                  Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
                                },
                                child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    controller.sites[index].getName(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              )),
                              AppStyle.hGap4,
                              IconButton(onPressed: (){}, icon: Icon(Icons.change_circle_outlined))
                            ],
                          )
                      );
                    },
                  )),
              backgroundColor: Colors.white,
            ));
  }
}
