/*
 * @File     : spider.dart
 * @Author   : jade
 * @Date     : 2024/8/23 下午3:11
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_log/drama_source_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:cat_vod/cat_vod.dart' as CatVod;
import 'package:ok_http/ok_http.dart';
import 'package:quick_js/src/utils/module.dart';
import 'package:flutter/services.dart' show rootBundle;

class Spider extends CatVod.Spider {
  Map<String, dynamic>? _jsObject;
  late String? _key;
  late String? _api;
  late bool? _cat;

  late JavascriptRuntime javascriptRuntime;

  Spider(String key, String api) {
    this._key = key;
    this._api = api;
  }

  @override
  Future<void> initEngine() async {
    javascriptRuntime =
        getJavascriptRuntime(forceJavascriptCoreOnAndroid: false);
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
    Log.d("JS测试demo${asyncResult.stringResult}");
    await _createObj();
  }

  @override
  Future<void> init(String ext) async {
    // TODO: implement init
    return super.init(ext);
  }

  _createObj() async {

    javascriptRuntime.onMessage("local", (args) async {
        Log.i(args);
    });

    String jsEval = "__jsEvalReturn";
    String spider = "__JS_SPIDER__";
    String global = "globalThis." + spider;
    String content = await Module.get().fetch(_api!);
    if (content.startsWith("//bb"))
      Module.get().bb(content);
    else
      await javascriptRuntime.evaluate(content.replaceAll(spider, global),
          sourceUrl: _api);
    String jsContent =
        await rootBundle.loadString("packages/quick_js/assets/js/lib/test.js");
    Log.i(jsContent);
    JsEvalResult result = await javascriptRuntime.evaluate(jsContent, sourceUrl: _api);
    if (content.startsWith("//bb") || content.contains(jsEval)) _cat = true;


  }
}
