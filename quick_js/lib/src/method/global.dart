/*
 * @File     : global.dart
 * @Author   : jade
 * @Date     : 2024/9/6 9:19
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:convert';

import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:cat_vod/cat_vod.dart';
import 'package:ok_http/ok_http.dart';
class Global{
  static IsolateFunction _s2t = IsolateFunction((String text) {
    return Trans.s2t(passBool: false, text: text);
  });

  static IsolateFunction _t2s =  IsolateFunction((String text) {
    return Trans.t2s(passBool: false, text: text);
  });

  static IsolateFunction _setTimeout = IsolateFunction((func,int timeout) {
    return Future.delayed(Duration(seconds: timeout), () => func);
  });

  static IsolateFunction http = IsolateFunction((String url,options) async{
      options = Json.parse(jsonEncode( options));
      try{
        var response = await OkHttp.instance.req(url,options);
        var resonseHeaders = response.headers.map;
        var headers =  {};
        for (var headerKey in resonseHeaders.keys){
          var value = null;
          try{
            value  = jsonDecode(resonseHeaders[headerKey]![0]);
          }catch(e){
            value = resonseHeaders[headerKey]![0];
          }
          if (value.runtimeType == String || value.runtimeType == List<String>){
            headers[headerKey] = value;
          }
        }
        if (response is String){
          var content = response.data.replaceAll("\\","");
          return {"code":response.statusCode, "headers":headers, "content": content};
        }else if (response.data is Map){
          return {"code":response.statusCode, "headers":headers, "content": jsonEncode(response.data)};
        }
        else{
          return {"code":response.statusCode, "headers":headers, "content": response.data};
        }
      }
      catch(e){
        return {"code":400,"headers":{},"content":base64Encode(utf8.encode(e.toString()))};
      }
  });

  static Future<String> getProxy(bool local) async{
    return await Proxy.getUrl(local) + "?do=js";
  }


  static IsolateFunction _js2Proxy = IsolateFunction((bool dynamic,int siteType,String siteKey,String url,headers) async{
    return await getProxy(!dynamic) + "&from=catvod" + "&siteType=" + siteType.toString() + "&siteKey=" + siteKey + "&header=" + Uri.encodeFull(headers.toString()) + "&url=" + Uri.encodeFull(url);
  });

  static IsolateFunction _print = IsolateFunction((val) {
    print(val);
  });

  // static IsolateFunction _md5 = IsolateFunction((String text) async{
  //   return await Util.md5(src: text);
  // });

  static List setPrint(){
    return ["print",_print];
  }

  static List setMd5X(){
    return ["md5X",(String text) {
        return Util.md5(src: text);
  }];
  } // 有返回值的不能用IsolateFunction，除非JS中使用await关键词

  static List setJs2Proxy(){
    return ["js2Proxy",_js2Proxy];
  }

  static List setHttp(){
    return ["http",http];
  }

  static List setS2t(){
    return ["s2t",_s2t ];
  }

  static List setT2s(){
    return ["t2s",_t2s];
}

  static List setTimeout() {
    return [
      "setTimeout", _setTimeout,
    ];
  }
}