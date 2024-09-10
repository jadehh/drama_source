/*
 * @File     : spider.dart
 * @Author   : jade
 * @Date     : 2024/8/23 下午3:11
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:convert';

import 'package:drama_source_log/drama_source_log.dart';
import 'package:cat_vod/cat_vod.dart' as CatVod;
import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quick_js/src/method/global.dart';
import 'package:quick_js/src/method/console.dart';
import 'package:quick_js/src/method/local.dart';
import 'package:quick_js/src/utils/module.dart';



class Spider extends CatVod.Spider {
  late String? _key;
  late String? _api;
  late bool? _cat;
  IsolateQjs? _ctx;

  Spider(String key, String api) {
    this._key = key;
    this._api = api;
    _cat = false;
    _ctx = null;
  }

  @override
  Future init(String ext) async {
    await  initEngine();
    await _cfg(ext);
    await _ctx!.evaluate("__JS_SPIDER__.init(ext)");
    Log.i("Java Script 初始化完成");
  }



  @override
  Future initEngine() async {
    if (_ctx == null) await _createCtx();
    await _createObj();
  }

  @override
  Future<String> homeContent(bool filter) async {
    return await _ctx!.evaluate("__JS_SPIDER__.home(${filter})");
  }

  @override
  Future<String> homeVideoContent() async{
    return await _ctx!.evaluate("__JS_SPIDER__.homeVod()");
  }




  _createCtx() async{
    _ctx = IsolateQjs(moduleHandler: (String moduleName) async{
      String content = await Module.get().fetch(moduleName);
      return content.startsWith("//bb") ?  utf8.decode(Module.get().bb(content)) : content;
    });
    try{
      JSInvokable setToGlobalObject = await _ctx!.evaluate("(key, val) => { this[key] = val; }");
      await setToGlobalObject.invoke(Console.setConsole());
      await setToGlobalObject.invoke(Global.setTimeout());
      await setToGlobalObject.invoke(Global.setHttp());
      await setToGlobalObject.invoke(Global.setPrint());
      await setToGlobalObject.invoke(Global.setJs2Proxy());
      await setToGlobalObject.invoke(Global.setS2t());
      await setToGlobalObject.invoke(Global.setT2s());
      await setToGlobalObject.invoke(Global.setMd5X());
      await setToGlobalObject.invoke(Local.setLocal());
      setToGlobalObject.free();
      await _ctx!.evaluate('print(["1","2"])');

      // await _ctx!.evaluate('console.log("Hello QuickJs");');
      // var a = await _ctx!.evaluate('s2t("123");');
      // var b = await _ctx!.evaluate('setTimeout(s2t("123"),5);');
      // await _ctx!.evaluate('local.set("cache","cookie","quickjs")');
      // var d = await _ctx!.evaluate('local.get("cache","cookie")');
      // print(a);

    }
    catch(e,stackTrace){
      Log.e(e.toString(), stackTrace);
    }
  }

  _createObj() async {
    try {
      String jsEval = "__jsEvalReturn";
      String spider = "__JS_SPIDER__";
      String global = "globalThis." + spider;
      String content = await Module.get().fetch(_api!);
      if (content.startsWith("//bb")) Log.w("待开发功能,后续适配JavaScript BB类型");
      else await _ctx!.evaluate(content.replaceAll(spider, global), name: _api,evalFlags:JSEvalFlag.MODULE);
      _ctx!.evaluate((await rootBundle.loadString("packages/quick_js/assets/js/lib/spider.js")).replaceAll("%s", _api!),evalFlags: JSEvalFlag.MODULE);
      if (content.startsWith("//bb") || content.contains(jsEval)) _cat = true;
      // var b = await _ctx!.evaluate("'123'.toString()");
      // var c = await _ctx!.evaluate("'123'.toString()");
      // var a = await _ctx!.evaluate('s2t("123")');
      // var x = await _ctx!.evaluate('md5X("123");');
      // var d = await _ctx!.evaluate('Object.keys({"x":"1","y":2})');
      Log.i("Java Script 环境初始化完成");



    }catch (e,stackTrace){
      Log.e("Java Script 环境初始化失败:${e.toString()}", stackTrace);
    }
  }

  _cfg(String ext) async{
    JSInvokable setToGlobalObject = await _ctx!.evaluate("(key, val) => { this[key] = val; }");
    if (CatVod.Json.invalid(ext)) await setToGlobalObject.invoke(["ext",{"stype":3,"skey":_key,"ext":ext}]);
    else await setToGlobalObject.invoke(["ext",{"stype":3,"skey":_key,"ext":ext}]);
    setToGlobalObject.free();
  }
}
