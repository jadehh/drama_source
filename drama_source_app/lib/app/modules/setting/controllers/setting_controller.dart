/*
 * @File     : setting_controller.dart
 * @Author   : jade
 * @Date     : 2024/07/11 04:34:12
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_app/app/modules/setting/dialog/config_dialog.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SettingController extends GetxController with WidgetsBindingObserver {
  final languageStr = Local.setting_fllow_system.tr.obs;

  final vodUrl = "".obs;

  final liveUrl = "".obs;

  final wallUrl = "".obs;

  final cache = "".obs;

  late int _type;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getLanguage();
    vodUrl.value = await VodConfig.getDesc();
    liveUrl.value = await LiveConfig.getDesc();
    wallUrl.value = await WallConfig.getDesc();
    _setCacheText();
    EventBus.instance.listen(
      RefreshEvent.kRefresh,
      (index) async {
        switch (index) {
          case RefreshType.CONFIG:
            _setCacheText();
            vodUrl.value = await VodConfig.getDesc();
            liveUrl.value = await LiveConfig.getDesc();
            wallUrl.value = await WallConfig.getDesc();
            break;
        }
      },
    );
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    getLanguage();
  }

  // 打开配置
  void openDialog(int dialogType) {
    _type = dialogType;
    Get.dialog(ConfigDialog(type: _type));
  }

  //获取语言
  void getLanguage() {
    switch (Setting.getLanguage()) {
      case 0:
        languageStr.value = Local.setting_fllow_system.tr;
        break;
      case 1:
        languageStr.value = "中文简体";
        break;
      case 2:
        languageStr.value = "繁體中文";
        break;
      case 3:
        languageStr.value = 'English';
        break;
      default:
        languageStr.value = Local.setting_fllow_system.tr;
        break;
    }
  }

  setConfigByConfig(Config config) async {
    if (config.getUrl()!.startsWith("file")) {
    } else {
      await _load(config);
    }
  }

  setConfig() {
    switch (_type) {
      case 0:
        SmartDialog.dismiss();
        RefreshEvent.video();
        RefreshEvent.config();
        break;
      case 1:
        SmartDialog.dismiss();
        RefreshEvent.config();
        break;
      case 2:
        SmartDialog.dismiss();
        RefreshEvent.config();
        break;
    }
  }

  _load(Config config) async {
    switch (config.getType()) {
      case 0:
        Notify.progress();
        SmartDialog.showLoading();
        await VodConfig.sLoad(config, _getCallback());
        vodUrl.value = config.getDesc();
        break;
      case 1:
        Notify.progress();
        await LiveConfig.sload(config, _getCallback());
        liveUrl.value = config.getDesc();
        break;
      case 2:
        Notify.progress();
        await WallConfig.sload(config, _getCallback());
        wallUrl.value = config.getDesc();
        break;
    }
  }

  Callback _getCallback() {
    Callback callBack = Callback(success, error);
    return callBack;
  }

  void success({String? message}) {
    setConfig();
  }

  void error(String message) {
    SmartDialog.showToast(message);
    setConfig();
  }

  setWallDefault() async {
    await WallConfig.refresh(
        Setting.getWall() == 4 ? 1 : Setting.getWall() + 1);
  }

  setWallRefresh() async {
    Notify.progress();
    await WallConfig.get().load(Callback(() {
      SmartDialog.dismiss();
      _setCacheText();
    }, (String msg) {
      SmartDialog.dismiss();
      SmartDialog.showToast(msg);
    }));
  }

  _setCacheText() {
    FileUtil.getCacheSize(Callback((String result) {
      cache.value = result;
    }, () {}));
  }

  onCache() {
    FileUtil.clearCache(Callback(() async {
      (await VodConfig.get().getConfig()).json("").save();
      _setCacheText();
    }, () {}));
  }
}
