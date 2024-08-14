/*
 * @File     : app_pages.dart
 * @Author   : jade
 * @Date     : 2024/07/11 01:32:22
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/page/detail/bindings/vod_detail_binding.dart';
import 'package:dramasource/page/detail/views/vod_detail_view.dart';
import 'package:dramasource/page/download/bindings/download_binding.dart';
import 'package:dramasource/page/download/views/download_view.dart';
import 'package:dramasource/page/setting/bindings/language_binding.dart';
import 'package:dramasource/page/setting/bindings/setting_binding.dart';
import 'package:dramasource/page/setting/views/language_setting_view.dart';
import 'package:dramasource/page/setting/views/setting_view.dart';
import 'package:dramasource/page/vod/bindings/vod_bindings.dart';
import 'package:dramasource/page/vod/views/vod_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: _Paths.VOD,
        participatesInRootNavigator: true,
        transition: Transition.topLevel,
        // preventDuplicates: true,
        page: () => const VodView(),
        binding: VodBinding()),
    GetPage(
        name: _Paths.SETTING,
        participatesInRootNavigator: true,
        transition: Transition.topLevel,
        // preventDuplicates: true,
        page: () => const SettingView(),
        binding: SettingdBinding()),
    GetPage(
        name: _Paths.LANGUAGESETTING,
        participatesInRootNavigator: true,
        transition: Transition.topLevel,
        // preventDuplicates: true,
        page: () =>   const LanguageSettingsView(),
        binding: LanguageBinding(),
        ),
    GetPage(
      name: _Paths.DOWNLOAD,
      transition: Transition.downToUp,
      // preventDuplicates: true,
      page: () => const DownloadView(),
      binding: DownloadBinding(),
    ),
     GetPage(
      name: _Paths.DETAIL,
      transition: Transition.downToUp,
      // preventDuplicates: true,
      page: () =>  const VodDetailView(),
      binding: VodDetailBinding(),
    ),
  ];

  AppPages._();
}
