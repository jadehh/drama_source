/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-08-14 14:03:23
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\download\views\download_view.dart
 * 
 */
import 'package:dramasource/page/download/controllers/download_controller.dart';
import 'package:dramasource/page/download/views/avj_esample_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DownloadView extends GetView<DownloadController> {
  const DownloadView({super.key});

 @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloadController>(
      init: DownloadController(),
      builder:(controller) => Scaffold(
      appBar: AppBar(
        title: const Text('FlutterJS Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(()=>Text(
              'JS Evaluate Result:\n\n${controller.jsResult.value}\n',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            )),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  'Click on the big JS Yellow Button to evaluate the expression bellow using the flutter_js plugin'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Math.trunc(Math.random() * 100).toString();",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
             ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AjvExample(
                      //widget.javascriptRuntime,
                      controller.javascriptRuntime),
                ),
              ),
              child: const Text('See Ajv Example'),
            ),
            SizedBox.fromSize(size: const Size(double.maxFinite, 20)),
            ElevatedButton(
              child: const Text('Fetch Remote Data'),
              onPressed: () async {
                controller.evateClick();
              },
            ),
            Obx(()=>Text(
              'QuickJS Version\n${controller.quickjsVersion}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.transparent,
        child: Text("Float"),
        onPressed: () async {
            controller.floatClick();
        },
      ),
    ));
  }
}
