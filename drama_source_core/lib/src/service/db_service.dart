/*
 * @File     : db_service.dart
 * @Author   : jade
 * @Date     : 2024/08/19 04:04:54
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/drama_source_core.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';


class DBService extends GetxService {
  static DBService get instance => Get.find<DBService>();
  late Box<Config> configBox;

  Future init() async {
    configBox = await Hive.openBox("Config");
  }
}
