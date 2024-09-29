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
    if (_cat!);
    await initEngine();
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
  Future<String> homeVideoContent() async {
    try {
      return await _ctx!.evaluate("__JS_SPIDER__.homeVod()");
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return "";
    }
  }

  @override
  Future<String> categoryContent(String tid, String pg, bool filter,
      Map<String, dynamic> extend) async {
    try {
      return await _ctx!.evaluate(
          "__JS_SPIDER__.category('${tid}','${pg}',${filter},${jsonEncode(
              extend)})");
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      return "";
    }
  }

  @override
  Future<dynamic> proxyLocal(Map<String, String> params)  async{
    if (params.containsKey("from")) {
      if (params["from"] == "catvod") {
        return await _proxy2(params);
      }
    }
    return _proxy1(params);
  }


  _createCtx() async {
    _ctx = IsolateQjs(moduleHandler: (String moduleName) async {
      String content = await Module.get().fetch(moduleName);
      return content.startsWith("//bb")
          ? utf8.decode(Module.get().bb(content))
          : content;
    });
    try {
      JSInvokable setToGlobalObject = await _ctx!.evaluate(
          "(key, val) => { this[key] = val; }");
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

      // await _ctx!.evaluate('console.log("Hello QuickJs");');
      // var a = await _ctx!.evaluate('s2t("123");');
      // var b = await _ctx!.evaluate('setTimeout(s2t("123"),5);');
      // await _ctx!.evaluate('local.set("cache","cookie","quickjs")');
      // var d = await _ctx!.evaluate('local.get("cache","cookie")');

      // var content = "{\"code\":1,\"msg\":\"获取手动标签数据成功\",\"data\":[{\"title\":\"今日推荐\",\"video\":[{\"id\":563838,\"title\":\"庆余年 第二季\",\"score\":\"7.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":36,\"playlist\":{\"title\":\"第36集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2024\\/05\\/16\\/78df96b1b2e4ba578c53dc9201688854.JPG\"},{\"id\":562381,\"title\":\"潜行\",\"score\":\"5.5\",\"finished\":0,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":1,\"need_gold_vip\":0,\"playlist_length\":3,\"playlist\":{\"title\":\"BD国粤双语中字\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2024\\/03\\/14\\/310144ea527e76805e042a91c11f5ab1.jpg\"},{\"id\":563274,\"title\":\"烈焰\",\"score\":\"7.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":40,\"playlist\":{\"title\":\"第40集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2024\\/03\\/13\\/d4c8f9663ab7cd5edc4bef6b7815a8ed.jpg\"},{\"id\":563292,\"title\":\"欢乐颂5\",\"score\":\"7.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":34,\"playlist\":{\"title\":\"第34集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2024\\/03\\/17\\/9e33ba7a425febec96cae123194c9cf0.JPG\"},{\"id\":563301,\"title\":\"与凤行\",\"score\":\"8.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":39,\"playlist\":{\"title\":\"第39集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2024\\/03\\/18\\/6d0b51535098ea96cc8aefe84c359558.JPG\"},{\"id\":563162,\"title\":\"行尸走肉：存活之人\",\"score\":\"9.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":6,\"playlist\":{\"title\":\"第06集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2024\\/02\\/29\\/96388485cfa26eb7fd1d9238926ef282.JPG\"},{\"id\":563318,\"title\":\"三体 第一季\",\"score\":\"8.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":8,\"playlist\":{\"title\":\"第08集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2024\\/03\\/21\\/2bf00b2e6b1072d34e41df94a7b5ea3e.JPG\"},{\"id\":562466,\"title\":\"武动乾坤 第四季\",\"score\":\"6.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":12,\"playlist\":{\"title\":\"第12集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2023\\/11\\/25\\/f6ad474ecf1bf7107decebd902cd6775.JPG\"},{\"id\":561098,\"title\":\"斗罗大陆2：绝世唐门\",\"score\":\"7.0\",\"finished\":0,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":67,\"playlist\":{\"title\":\"第67集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2023\\/06\\/24\\/02fb1a828567c4b9f0339ea436e1dbe0.JPG\"},{\"id\":561366,\"title\":\"凡人修仙传：星海飞驰篇\",\"score\":\"9.2\",\"finished\":0,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":48,\"playlist\":{\"title\":\"第44集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2023\\/07\\/30\\/7b4ab75eac16d1142257e70ba5bc4b87.JPG\"},{\"id\":555953,\"title\":\"斗破苍穹三年之约\",\"score\":\"6.0\",\"finished\":1,\"shared\":0,\"is_look\":0,\"standbytime\":0,\"definition\":3,\"need_gold_vip\":0,\"playlist_length\":13,\"playlist\":{\"title\":\"第13集\"},\"path\":\"http:\\/\\/img.shifen.me\\/upload\\/video\\/2021\\/10\\/31\\/81a191e3ed3f32df049928be5d675e78.jpg\"}]}]}";
      // await _ctx!.evaluate("var x = '${content}'");
      // await _ctx!.evaluate("console.log(x)");
      // var a = await _ctx!.evaluate("JSON.parse(x)");
      // print(a);
    }
    catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
    }
  }

  _createObj() async {
    try {
      String jsEval = "__jsEvalReturn";
      String spider = "__JS_SPIDER__";
      String global = "globalThis." + spider;
      String content = await Module.get().fetch(_api!);
      if (content.startsWith("//bb"))
        Log.w("待开发功能,后续适配JavaScript BB类型");
      else
        await _ctx!.evaluate(content.replaceAll(spider, global), name: _api,
            evalFlags: JSEvalFlag.MODULE);
      _ctx!.evaluate((await rootBundle.loadString(
          "packages/quick_js/assets/js/lib/spider.js")).replaceAll("%s", _api!),
          evalFlags: JSEvalFlag.MODULE);
      if (content.startsWith("//bb") || content.contains(jsEval)) _cat = true;
      // var b = await _ctx!.evaluate("'123'.toString()");
      // var c = await _ctx!.evaluate("'123'.toString()");
      // var a = await _ctx!.evaluate('s2t("123")');
      // var x = await _ctx!.evaluate('md5X("123");');
      // var d = await _ctx!.evaluate('Object.keys({"x":"1","y":2})');
      Log.i("Java Script 环境初始化完成");
    } catch (e, stackTrace) {
      Log.e("Java Script 环境初始化失败:${e.toString()}", stackTrace);
    }
  }

  _cfg(String ext) async {
    JSInvokable setToGlobalObject = await _ctx!.evaluate(
        "(key, val) => { this[key] = val; }");
    if (CatVod.Json.invalid(ext))
      await setToGlobalObject.invoke(
          ["ext", {"stype": 3, "skey": _key, "ext": ext}]);
    else
      await setToGlobalObject.invoke(
          ["ext", {"stype": 3, "skey": _key, "ext": ext}]);
    setToGlobalObject.free();
  }

  Map<String,String> _parse(String header){
    Map<String,String> params = {};
    var paramsList = header.replaceAll("{", "").replaceAll("}", "").split(",");
    for(var param in paramsList){
      var paramList = param.split(":");
      params[paramList[0].trim()] = paramList[1].trim();
    }
    return params;
  }


  dynamic _proxy1(Map<String, String> params) {
  }




  dynamic _proxy2(Map<String, String> params) async {
    String? url = params["url"];
    String? header = params["header"];
    List<String> array = url!.split("/");
    var jsHeader = jsonEncode(_parse(header!));
    // var jsHeader = jsonEncode({});
    var jsArray = jsonEncode(array);
    try{
      var result = await _ctx!.evaluate("__JS_SPIDER__.proxy(${jsArray},${jsHeader})");
      return result;
    }catch(e,stackTrace){
      return jsonEncode({"code":400,"data":e.toString()});
    }
  }
}
