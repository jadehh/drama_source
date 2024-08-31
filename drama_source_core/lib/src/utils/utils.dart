/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:11:06
 * @LastEditTime: 2024-08-20 10:03:51
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\utils\utils.dart
 * 
 */

import 'dart:io';

import 'package:drama_source_core/src/requests/common_request.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static late PackageInfo packageInfo;
  

  static DateFormat timeFormat = DateFormat("HH:mm:ss");

  // 根据屏幕宽度自使用大小
  static int calculateColumnCount(BuildContext context,double width) {
    // 获取屏幕宽度
    double sceenWidth = MediaQuery.of(context).size.width;
    // 计算列数
    int columns = (sceenWidth / width).floor(); // 假设每个Item的宽度为150
    return columns > 0 ? columns : 1; // 至少有一列
  }


  static Future showStatement(EdgeInsetsGeometry padding) async {
    var text = await rootBundle.loadString("assets/statement.txt");

    var result = await showAlertDialog(
      padding,
      text,
      selectable: true,
      title: "免责声明",
      confirm: "已阅读并同意",
      cancel: "退出",
    );
    if (!result) {
      exit(0);
    }
  }


  static void checkUpdate(EdgeInsetsGeometry padding,Widget padWidget,{bool showMsg = false}) async {
    try {
      int currentVer = Utils.stringToInt(packageInfo.version);
      CommonRequest request = CommonRequest();
      var versionInfo = await request.checkUpdate();
      if (versionInfo.versionNum > currentVer) {
        Get.dialog(
          AlertDialog(
            title: Text(
              "发现新版本 ${versionInfo.version}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            content: Text(
              versionInfo.versionDesc,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
            actionsPadding: padding,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("取消"),
                    ),
                  ),
                  padWidget,
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                      onPressed: () {
                        launchUrlString(
                          versionInfo.downloadUrl,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: const Text("更新"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        if (showMsg) {
          SmartDialog.showToast("当前已经是最新版本了");
        }
      }
    } catch (e) {
      Log.logPrint(e);
      if (showMsg) {
        SmartDialog.showToast("检查更新失败");
      }
    }
  }


  

  


  static int stringToInt(String input) {
    // 正则表达式匹配整数，包括负数和整数
    RegExp exp = RegExp(r'\d+');
    // 使用正则表达式查找所有匹配的整数
    Iterable<Match> matches = exp.allMatches(input);
    // 将匹配的字符串提取出来
    return int.parse(matches.map((match) => match.group(0)).join());
  }

  static String onlineToString(int num) {
    if (num >= 10000) {
      return "${(num / 10000.0).toStringAsFixed(1)}万";
    }
    return num.toString();
  }


  static Future<bool> showAlertDialog(
    EdgeInsetsGeometry padding,
    String content, {
    String title = '',
    String confirm = '',
    String cancel = '',
    bool selectable = false,
    List<Widget>? actions,
  }) async {
    var result = await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Container(
          constraints: const BoxConstraints(
            maxHeight: 400,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: padding,
              child: selectable ? SelectableText(content) : Text(content),
            ),
          ),
        ),
        actions: [
          ...?actions,
          TextButton(
            onPressed: (() => Get.back(result: false)),
            child: Text(cancel.isEmpty ? "取消" : cancel),
          ),
          TextButton(
            onPressed: (() => Get.back(result: true)),
            child: Text(confirm.isEmpty ? "确定" : confirm),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
