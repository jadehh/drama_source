/*
 * @Author: jadehh
 * @Date: 2024-07-11 10:59:30
 * @LastEditTime: 2024-08-14 13:57:54
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\download\controllers\download_controller.dart
 * 
 */
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_js/flutter_js.dart';

class DownloadController extends GetxController {
  final JavascriptRuntime javascriptRuntime = getJavascriptRuntime(forceJavascriptCoreOnAndroid: false);

  var jsResult = "NULL".obs;

  var quickjsVersion = "NULL".obs;

  @override
  void onInit() {
    super.onInit();
    javascriptRuntime.setInspectable(true);
    javascriptRuntime.onMessage('getDataAsync', (args) async {
      await Future.delayed(const Duration(seconds: 1));
      final int count = args['count'];
      Random rnd = Random();
      final result = <Map<String, int>>[];
      for (int i = 0; i < count; i++) {
        result.add({'key$i': rnd.nextInt(100)});
      }
      return result;
    });
    javascriptRuntime.onMessage('asyncWithError', (_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      return Future.error('Some error');
    });
  }

  Future<String> evalJS() async {
    JsEvalResult jsResult = await javascriptRuntime.evaluateAsync(
      """
            if (typeof MyClass == 'undefined') {
              var MyClass = class  {
                constructor(id) {
                  this.id = id;
                }
                
                getId() { 
                  return this.id;
                }
              }
            }
            async function test() {
              var obj = new MyClass(1);
              var jsonStringified = JSON.stringify(obj);
              var value = Math.trunc(Math.random() * 100).toString();
              var asyncResult = await sendMessage("getDataAsync", JSON.stringify({"count": Math.trunc(Math.random() * 10)}));
              var err;
              try {
                await sendMessage("asyncWithError", "{}");
              } catch(e) {
                err = e.message || e;
              }
              return {"object": jsonStringified, "expression": value, "asyncResult": asyncResult, "expectedError": err};
            }
            test();
            """,
      sourceUrl: 'script.js',
    );
    javascriptRuntime.executePendingJob();
    JsEvalResult asyncResult = await javascriptRuntime.handlePromise(jsResult);
    return asyncResult.stringResult;
  }

  testClick(){
    jsResult.value = "测试";
  }

  floatClick() async {
    final result = await evalJS();
    jsResult.value = result;
  }

  evateClick() async {
    var asyncResult = await javascriptRuntime.evaluateAsync("""
                fetch('https://raw.githubusercontent.com/abner/flutter_js/master/FIXED_RESOURCE.txt').then(response => response.text());
              """);
    javascriptRuntime.executePendingJob();
    final promiseResolved = await javascriptRuntime.handlePromise(asyncResult);
    var result = promiseResolved.stringResult;
    quickjsVersion.value = result;
  }

   @override
  void dispose() {
    javascriptRuntime.dispose();
    super.dispose();
  }
}
