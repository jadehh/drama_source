/*
 * @File     : highlight_button.dart
 * @Author   : jade
 * @Date     : 2024/08/19 04:26:41
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */






import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/widgets/highlight_widget.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class HighlightButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final Widget? icon;
  final AppFocusNode focusNode;
  final Function()? onTap;
  final bool autofocus;
  final bool selected;
  const HighlightButton({
    this.iconData,
    required this.text,
    this.icon,
    this.onTap,
    required this.focusNode,
    this.autofocus = false,
    this.selected = false,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HighlightWidget(
        focusNode: focusNode,
        borderRadius: AppStyle.radius32,
        color: Colors.white10,
        onTap: onTap,
        autofocus: autofocus,
        selected: selected,
        child: Container(
          height: 32,
          // width: 32,
          padding: AppStyle.edgeInsetsH16,
          decoration: BoxDecoration(
            borderRadius: AppStyle.radius12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildIcon(),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: (focusNode.isFoucsed.value || selected)
                      ? Colors.blue
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcon() {
    if (icon != null || iconData != null) {
      return Padding(
        padding: AppStyle.edgeInsetsR4,
        child: icon ??
            Icon(
              iconData,
              size: 12,
              color: (focusNode.isFoucsed.value || selected)
                  ? Colors.blue
                  : Colors.white,
            ),
      );
    }
    return const SizedBox();
  }
}
