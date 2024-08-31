/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:17:36
 * @LastEditTime: 2024-08-21 21:28:39
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\config\wall_config.dart
 * 
 */


import 'dart:io';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:get/get.dart';
import 'package:ok_http/requests/ok_http.dart';

class WallConfig {
  Config? _config;
  bool _sync = false;

  static final WallConfig _instance = WallConfig._internal();

  static WallConfig get instance => _instance;

  factory WallConfig() {
    return _instance;
  }

  WallConfig._internal();

  static WallConfig get() {
    return _instance;
  }

  static Future<String> getUrl() async {
    return (await get().getConfig()).getUrl()!;
  }

  static Future<String> getDesc() async {
    return (await get().getConfig()).getDesc();
  }

  static Future sload(Config config, Callback callback) async {
    await get().clear().config(config).load(callback);
  }

  Future<WallConfig> init() async {
    return config(await Config.wall());
  }

  WallConfig config(Config config) {
    this._config = config;
    if (config.getUrl() == null) return this;
    this._sync = config.getUrl() == VodConfig.get().getWall();
    return this;
  }

  WallConfig clear() {
    this._config = null;
    return this;
  }

  Future<Config> getConfig() async {
    return _config == null ? await Config.wall() : _config!;
  }

  Future load(Callback callback) async {
    await _loadConfig(callback);
  }

  Future _loadConfig(Callback callback) async {
    try {
      File file = await _write(File(FileUtil.getWall(0)));
      if (await file.exists() && await file.length() > 0)
        await refresh(0);
      else
        config((await Config.find(url: VodConfig.get().getWall(), type: 2))!);
      callback.success();
      await _config!.update();
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      callback.error(Notify.getError(Local.error_config_parse.tr, e));
      config((await Config.find(url: VodConfig.get().getWall(), type: 2))!);
    }
  }

  Future<File> _write(File file) async {
    if ((await getUrl()).startsWith("file"))  Path.copy(inFile: await Path.local(await getUrl()), outFile: file);
    else if ((await getUrl()).startsWith("assets"))  Path.copy(str: await Asset.open(await getUrl()), outFile: file);
    else if ((await getUrl()).startsWith("http"))  Path.write(file, uint8List: await OkHttp.instance.getData(await getUrl()));
    return file;
  }

  bool needSync(String url) {
    return _sync ||
        TextUtils.isEmpty(_config?.getUrl()) ||
        url == _config?.getUrl();
  }

  static Future refresh(int index) async {
    await Setting.putWall(index);
    Log.d("刷新背景图片:${Setting.getWall()}");
    RefreshEvent.wall();
  }
}
