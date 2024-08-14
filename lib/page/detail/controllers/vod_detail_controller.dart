/*
 * @Author: jadehh
 * @Date: 2024-07-30 14:08:59
 * @LastEditTime: 2024-07-30 15:06:21
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\detail\controllers\vod_detail_controller.dart
 * 
 */
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VodDetailController extends GetxController {
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void onInit() {
    super.onInit();
    player.open(Media('http://192.168.29.157:10086/hls/181/20240724/20240724153055/181_record.m3u8'));
  }
}






