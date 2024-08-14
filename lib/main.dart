/*
 * @Author: jadehh
 * @Date: 2024-07-10 13:47:18
 * @LastEditTime: 2024-08-14 09:08:13
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\main.dart
 * 
 */
import 'dart:ui';
import 'package:dramasource/core/language/language_utils.dart';
import 'package:dramasource/core/language/local.dart';
import 'package:dramasource/core/language/message.dart';
import 'package:dramasource/core/model/prefers.dart';
import 'package:dramasource/core/model/setting.dart';
import 'package:dramasource/page/root/views/root_view.dart';
import 'package:dramasource/routes/app_pages.dart';
import 'package:dramasource/theme/check_box_custom_theme.dart';
import 'package:dramasource/theme/icon_button_custom_style.dart';
import 'package:dramasource/theme/out_line_button_custom_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> initVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Setting.setBuildName(packageInfo.buildNumber);
  Setting.setVersion(packageInfo.version);
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefers.instance.init();
  await initVersion();
  if (kDebugMode) {
    print(Setting.getWall());
  }

  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
}

void main() async {
  await init();
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      locale: getLocale(),
      fallbackLocale: const Locale("zh", "CN"),
      title: Local.appName.tr,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey, // 设置主色
          backgroundColor: Colors.green, // 设置背景色
        ),
        checkboxTheme: CheckBoxCustomTheme().normalCheckBoxTheme(),
        tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
        useMaterial3: true,
        iconButtonTheme: IconButtonThemeData(
            style: IconButtonCustomStyle().lightIconButtonNormalStyle()),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutLineButtonCustomStyle().lightOutLineButtonNormalStyle(),
        ),
      ),
      darkTheme: ThemeData(
        // fontFamily: 'HarmonyOS',
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
      home: const RootView(),
    );
  }
}
