/*
 * @Author: jadehh
 * @Date: 2024-07-10 13:47:18
 * @LastEditTime: 2024-07-24 17:26:12
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
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:package_info_plus/package_info_plus.dart';

Future<void> initVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Setting.setBuildName(packageInfo.buildNumber);
  Setting.setVersion(packageInfo.version);
}

Future<void> init() async {
  await Prefers.instance.init();
  await initVersion();
  if (kDebugMode) {
    print(Setting.getWall());
  }
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
    return DynamicColorBuilder(
      builder: ((ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
          // dynamic取色成功m
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {}
        return GetMaterialApp(
          scrollBehavior: AppScrollBehavior(),
          debugShowCheckedModeBanner: false,
          translations: Messages(),
          locale: getLocale(),
          fallbackLocale: const Locale("zh", "CN"),
          title: Local.appName.tr,
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(
                  allowEnterRouteSnapshotting: false,
                ),
              },
            ),
          ),
          darkTheme: ThemeData(
            // fontFamily: 'HarmonyOS',
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          getPages: AppPages.routes,
          home: const RootView(),
        );
      }),
    );
  }
}
