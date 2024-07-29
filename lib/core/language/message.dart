/*
 * @File     : message.dart
 * @Author   : jade
 * @Date     : 2024/07/15 02:07:07
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:dramasource/core/language/local.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          Local.appName: Local.appName,
          Local.navVod: Local.navVod,
          Local.navLive: Local.navLive,
          Local.navSetting: Local.navSetting,
          Local.navDownload: Local.navDownload,
          //Setting
          Local.languageSetting: Local.languageSetting,
          Local.followerSystemLanguage: Local.followerSystemLanguage,
          Local.simplifiedChinese: Local.simplifiedChinese,
          Local.wallPaper: Local.wallPaper,
          Local.about: Local.about,
        },
        'zh_HK': {
          Local.appName: "劇源",
          Local.navVod: '點播',
          Local.navLive: '直播',
          Local.navSetting: '設置',
          Local.navDownload: '下載',
          //Setting
          Local.languageSetting: "語言設置",
          Local.followerSystemLanguage: "跟隨系統",
          Local.simplifiedChinese: "簡體中文",
          Local.wallPaper: "壁紙",
          Local.about: "關於",
        },
        'en_US': {
          Local.appName: "DramaSource",
          Local.navVod: 'Vod',
          Local.navLive: 'Live',
          Local.navSetting: 'Setting',
          Local.navDownload: 'Download',
          //Setting
          Local.languageSetting: "Language Setting",
          Local.followerSystemLanguage: "Follow System Language",
          Local.simplifiedChinese: "Simplified Chinese",
          Local.wallPaper: "wallPaper",
          Local.about: "about",
        },
      };
}
