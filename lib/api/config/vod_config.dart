/*
 * @File     : vod_config.dart
 * @Author   : jade
 * @Date     : 2024/08/15 04:15:32
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/db/bean/config.dart';

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
