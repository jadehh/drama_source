/*
 * @File     : shadow_card.dart
 * @Author   : jade
 * @Date     : 2024/08/20 10:03:02
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_app/app/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShadowCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final Function()? onTap;
  const ShadowCard({
    required this.child,
    this.radius = 8.0,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: Get.isDarkMode
            ? []
            : [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(.2),
                )
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppStyle.radius8,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
