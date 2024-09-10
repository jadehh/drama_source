/*
 * @Author: jadehh
 * @Date: 2024-08-19 13:09:33
 * @LastEditTime: 2024-08-21 17:35:24
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\model\language\message.dart
 * 
 */
import 'package:drama_source_core/src/model/language/Local.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          //App
          Local.app_name: Local.app_name,
          Local.app_exit:  Local.app_exit,
          Local.app_keep: Local.app_keep,
          Local.app_history:  Local.app_history,
          //Nav
          Local.nav_vod: Local.nav_vod,
          Local.nav_live: Local.nav_live,
          Local.nav_setting:Local.nav_setting,
          Local.nav_downloading:  Local.nav_downloading,
          //Setting
          // Local.setting_vod: Local.setting_vod,
          // Local.setting_live: Local.setting_live,
          Local.setting_wall: Local.setting_wall,
          Local.setting_player: Local.setting_player,
          Local.setting_danmu: Local.setting_danmu,
          Local.setting_custom: Local.setting_custom,
          Local.setting_config_cache: Local.setting_config_cache,
          Local.setting_cache_dir: Local.setting_cache_dir,
          Local.setting_reset: Local.setting_reset,
          Local.setting_quality: Local.setting_quality,
          Local.setting_size: Local.setting_size,
          Local.setting_aggregated_search: Local.setting_aggregated_search,
          Local.setting_language: Local.setting_language,
          Local.setting_parse_webview: Local.setting_parse_webview,
          Local.setting_fullscreen_menu_key: Local.setting_fullscreen_menu_key,
          Local.setting_home_menu_key: Local.setting_home_menu_key,
          Local.setting_home_site_lock: Local.setting_home_site_lock,
          Local.setting_incognito: Local.setting_incognito,
          Local.setting_remove_ad: Local.setting_remove_ad,
          Local.setting_small_window_back_key: Local.setting_small_window_back_key,
          Local.setting_home_display_name: Local.setting_home_display_name,
          Local.setting_home_ui: Local.setting_home_ui,
          Local.setting_home_buttons: Local.setting_home_buttons,
          Local.setting_doh: Local.setting_doh,
          Local.setting_proxy: Local.setting_proxy,
          Local.setting_cache: Local.setting_cache,
          Local.setting_backup: Local.setting_backup,
          Local.setting_restore: Local.setting_restore,
          Local.setting_version: Local.setting_version,
          Local.setting_about: Local.setting_about,
          Local.setting_keep_sync: Local.setting_keep_sync,
          Local.setting_history_sync: Local.setting_history_sync,
          Local.setting_storage: Local.setting_storage,
          Local.setting_off: Local.setting_off,
          Local.setting_on: Local.setting_on,
          // Live
          Local.live_pass: Local.live_pass,
          Local.live_line: Local.live_line,
          //Dialog
          Local.cancel: Local.cancel,
          Local.confirm: Local.confirm,
          //Keep
          Local.keep: Local.keep,
          //Play
          Local.play_now: Local.play_now,
          //Parse
          Local.parse: Local.parse,
          Local.parse_god: Local.parse_god,
          Local.parse_from: Local.parse_from,

          //Error
          Local.error_config_get: Local.error_config_get,
          Local.error_config_parse: Local.error_config_parse,
        },
        'zh_HK': {
          //Setting

          // Live
          Local.live_pass: "密碼",
          Local.live_line: "來源 %s",
          //Dialog
          Local.cancel: "取消",
          Local.confirm: "確認",
          Local.configHit: "請輸入接口…",
          //Keep
          Local.keep: "收藏",
          //Play
          Local.play_now: "正在播放：%s",
          //Parse
          Local.parse: "解析",
          Local.parse_god: "超級解析",
          Local.parse_from: "解析來自：%s",

          //Error
          Local.error_config_get: "配置取得失敗",
          Local.error_config_parse: "配置解析失敗",
        },
        'en_US': {
          //Setting

          // Live
          Local.live_pass: "Pass",
          Local.live_line: "Line %s",
          //Dialog
          Local.cancel: "cancel",
          Local.confirm: "confirm",
          Local.configHit: "Please enter the config…",
          //Keep
          Local.keep: "Keep",
          //Parse
          Local.parse: "Parse",
          Local.parse_god: "Super",
          Local.parse_from: "Parse from: %s",
          //Play
          Local.play_now: "Playing: %s",
          //Error
          Local.error_config_get: "Configuration get failed",
          Local.error_config_parse: "Configuration parse failed",
        },
      };
}
