/*
 * @Author: jadehh
 * @Date: 2024-08-14 14:45:40
 * @LastEditTime: 2024-08-15 18:30:06
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\quickjs\crawler\spider.dart
 * 
 */
 import 'package:dramasource/catvod/crawler/spider.dart';
import 'package:flutter_js/flutter_js.dart';

class JSSpider extends Spider{
    late String key;
    late String api;
    late JavascriptRuntime javascriptRuntime;
     JSSpider(String jsKey, String jsApi) {
        key = jsKey;
        api = jsApi;
        _createObj();

    }
    
    void initializeJS(){
      javascriptRuntime = getJavascriptRuntime(forceJavascriptCoreOnAndroid: false);
    }


    void _createObj() async {
        // String jsEval = "__jsEvalReturn";
        // String spider = "__JS_SPIDER__";
        // String global = "globalThis.$spider";
        // String? content = await Module.get().fetch(api);
        // if (content!.startsWith("//bb")){
        //   Module.get().bb(content);
        // } 
        // else ctx.evaluateModule(content.replace(spider, global), api);
        // ctx.evaluateModule(String.format(Asset.read("js/lib/spider.js"), api));
        // if (content.startsWith("//bb") || content.contains(jsEval)) cat = true;
        // jsObject = (JSObject) ctx.getProperty(ctx.getGlobalObject(), spider);
    }

 }




