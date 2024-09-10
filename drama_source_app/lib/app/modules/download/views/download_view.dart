/*
 * @File     : download_view.dart
 * @Author   : jade
 * @Date     : 2024/9/2 13:23
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_app/app/modules/download/controllers/download_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadView extends GetView<DownloadController>{
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JS engine test"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                      child: Text("evaluate"),
                      onPressed: () async {
                        await controller.ensureEngine();
                        await controller.eval();
                        
                      }),
                  TextButton(
                      child: Text("reset engine"),
                      onPressed: () async {
                        controller.close();
                      }),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey.withOpacity(0.1),
              constraints: BoxConstraints(minHeight: 200),
              child: TextField(
                  autofocus: true,
                  controller: controller.textEditingController,
                  decoration: null,
                  expands: true,
                  maxLines: null),
            ),
            SizedBox(height: 16),
            Text("result:"),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.green.withOpacity(0.05),
              constraints: BoxConstraints(minHeight: 100),
              child: Obx(()=>Text(controller.resp.value,style: TextStyle(color: Colors.red),)),
            ),
          ],
        ),
      ),
    );
  }
}