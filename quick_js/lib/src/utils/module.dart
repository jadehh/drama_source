/*
 * @File     : module.dart
 * @Author   : jade
 * @Date     : 2024/8/30 下午1:46
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:ok_http/requests/ok_http.dart';

class Module {
  final Map<String, String> _cache = {};


  static final Module _instance = Module._internal();

  static Module get instance => _instance;

  factory Module() {
    return _instance;
  }

  Module._internal(){
  }

  static Module get() {
    return _instance;
  }


  Future<String> fetch(String name) async {
    _cache.clear();
    if (_cache.containsKey(name)) return _cache[name]!;
    if (name.startsWith("http")) _cache[name] = await request(name);
    if (name.startsWith("assets")) _cache[name] = await Asset.read(name);
    if (name.startsWith("lib/")) _cache[name] = await Asset.read("js/" + name);
    return _cache[name]!;
  }

  Future<String> request(String url) async {
    try {
      Uri uri = Uri.parse(url);
      File file = File(Path.js(name: uri.pathSegments.last).absolute.path);
      if (file.existsSync()) return Path.read(file: file);
      Uint8List response = await OkHttp.instance.getData(url, header: {HttpHeaders.userAgentHeader: "Mozilla/5.0"});
      if (response.isEmpty) return "";
      bool cache = !("127.0.0.1" == uri.host);
      if (cache) await Path.write(file, uint8List: response);
      return response.toString();
    } catch (e,stackTrace) {
      Log.e(e.toString(), stackTrace);
      return "";
    }
  }

  Uint8List bb(String content) {
    Uint8List bytes = Base64Decoder().convert(content.substring(4));
    Uint8List newBytes = Uint8List(bytes.length-5);
    newBytes[0] = 1;
    for (int i=1; i < bytes.length-5;i ++ ){
      newBytes[i] = bytes[i];
    }
    return newBytes;
  }
}
