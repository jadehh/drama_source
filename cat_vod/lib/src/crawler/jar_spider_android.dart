/*
 * @File     : jar_spider.dart
 * @Author   : jade
 * @Date     : 2024/9/13 16:58
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:flutter/services.dart';

class JarSpiderAndroid extends Spider{
  final Map<String, dynamic> params;
  static  const MethodChannel _spiderChannel = const MethodChannel("com.example.drama_source_app/spider");
  JarSpiderAndroid(this.params){
  }
  @override
  Future init(String ext) async{
    params["ext"] = ext;
    return await _spiderChannel.invokeMethod("init",params);
  }

  @override
  Future<String> homeContent(bool filter) async {
    params["filter"] = filter;
    return await  _spiderChannel.invokeMethod("homeContent",params);
  }

  @override
  Future<String> homeVideoContent()  async{
    return await  _spiderChannel.invokeMethod("homeVideoContent",params);
  }
}
