/*
 * @Author: jadehh
 * @Date: 2024-08-19 13:09:33
 * @LastEditTime: 2024-08-19 13:09:37
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\model\message.dart
 * 
 */
/*
 * @File     : message.dart
 * @Author   : jade
 * @Date     : 2024/07/15 02:07:07
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/src/model/local.dart';
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
          //Dialog
          Local.cancel:Local.cancel,
          Local.confirm:Local.confirm,

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
          //Dialog
          Local.cancel:"取消",
          Local.confirm:"確認",
          Local.configHit:"請輸入接口…",
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
          //Dialog
          Local.cancel:"cancel",
          Local.confirm:"confirm",
          Local.configHit:"Please enter the config…",
        },
      };
}
