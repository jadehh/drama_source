/*
 * @File     : app_scaffold.dart
 * @Author   : jade
 * @Date     : 2024/08/19 04:34:36
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppScaffold extends StatelessWidget {
  final Widget child;
  final Visibility? bottomView;
  const AppScaffold({required this.child, this.bottomView, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<AppSettingsController>(builder: (controller){
            return Container(
             decoration:  BoxDecoration(
              image: DecorationImage(
                  image: controller.refreshImage(),
                  fit: BoxFit.cover),
            ),
            );
          },
          id: "wall"),
          Positioned.fill(child: child),
        ],
      ),
    bottomNavigationBar: bottomView);
  }
}
