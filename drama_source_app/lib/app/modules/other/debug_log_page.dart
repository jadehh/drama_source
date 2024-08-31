/*
 * @Author: jadehh
 * @Date: 2024-08-19 15:11:11
 * @LastEditTime: 2024-08-20 17:30:51
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\app\modules\other\debug_log_page.dart
 * 
 */
import 'dart:io';

import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';


class DebugLogPage extends StatelessWidget {
  const DebugLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log"),
        actions: [
          IconButton(
            onPressed: () async {
              var msg = Log.debugLogs
                  .map((x) => "${x.datetime}\r\n${x.content}")
                  .join('\r\n\r\n');
              var dir = await getApplicationDocumentsDirectory();
              var logFile = File(
                  '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.log');
              await logFile.writeAsString(msg);
              Share.shareXFiles([XFile(logFile.path)]);
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              Log.debugLogs.clear();
            },
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: Log.debugLogs.length,
          separatorBuilder: (_, i) => const Divider(),
          padding: AppStyle.edgeInsetsA12,
          itemBuilder: (_, i) {
            var item = Log.debugLogs[i];
            return SelectableText(
              "${item.datetime.toString()}\r\n${item.content}",
              style: TextStyle(
                color: item.color,
                fontSize: 12,
              ),
            );
          },
        ),
      ),
    );
  }
}
