/*
 * @File     : video_view.dart
 * @Author   : jade
 * @Date     : 2024/07/30 02:01:32
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/page/detail/controllers/vod_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VodDetailView extends GetView<VodDetailController> {
  const VodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialDesktopVideoControlsTheme(
          normal: MaterialDesktopVideoControlsThemeData(
        // Modify theme options:
        seekBarThumbColor: Colors.blue,
        seekBarPositionColor: Colors.blue,
        toggleFullscreenOnDoublePress: false,
        // Modify top button bar:
        topButtonBar: [
          const Spacer(),
          MaterialDesktopCustomButton(
            onPressed: () {
              debugPrint('Custom "Settings" button pressed.');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        // Modify bottom button bar:
        bottomButtonBar: const [
          Spacer(),
          MaterialDesktopPlayOrPauseButton(),
          Spacer(),
        ],
      ),
      fullscreen: const MaterialDesktopVideoControlsThemeData(),
      child: Scaffold(
        body: Video(
          controller: controller.controller,
        ),
      ),
    );
  }
}
