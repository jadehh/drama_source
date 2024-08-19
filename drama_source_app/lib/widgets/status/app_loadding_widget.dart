/*
 * @File     : app_loadding_widget.dart
 * @Author   : jade
 * @Date     : 2024/08/19 03:09:38
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */



import 'package:drama_source_core/src/app/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoaddingWidget extends StatelessWidget {
  const AppLoaddingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          boxShadow: Get.isDarkMode
              ? []
              : [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.grey.withOpacity(.2),
                  )
                ],
        ),
        child: const CupertinoActivityIndicator(
          radius: 10,
        ),
      ),
    );
  }
}
