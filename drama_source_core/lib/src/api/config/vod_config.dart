/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:00:12
 * @LastEditTime: 2024-08-19 11:17:27
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\config\vod_config.dart
 * 
 */
/*
 * @File     : vod_config.dart
 * @Author   : jade
 * @Date     : 2024/08/15 04:15:32
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:drama_source_core/src/model/db/bean/config.dart';

class VodConfig {
  Config? _config;

  static final VodConfig _instance = VodConfig._internal();

  static VodConfig get instance => _instance;

  factory VodConfig() {
    return _instance;
  }

  VodConfig._internal();

  static VodConfig get() {
    return _instance;
  }

  Future<Config> getConfig() async {
    return _config ?? await Config.vod();
  }

  static Future<String> getDesc() async {
    Config config = await get().getConfig();
    return config.getDesc();
  }

  static void load(Config config) {
    get().clear().config(config);
  }

  VodConfig config(Config config) {
    _config = config;
    return this;
  }

  VodConfig clear() {
    return this;
  }
}
