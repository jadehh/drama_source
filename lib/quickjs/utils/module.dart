/*
 * @File     : module.dart
 * @Author   : jade
 * @Date     : 2024/08/14 02:59:22
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:dramasource/catvod/utils/assert.dart';
import 'package:dramasource/catvod/utils/path.dart';

class Module {
  late HashMap<String, String> cache;

  static final Module _instance = Module._internal();

  static Module get instance => _instance;

  factory Module() {
    return _instance;
  }

  Module._internal() {
    cache = HashMap<String, String>();
  }

  static Module get() {
    return _instance;
  }

  Future<String?> fetch(String name) async {
    if (cache.containsKey(name)) {
      return cache[name];
    }
    if (name.startsWith("http")) {
      cache[name] = await _request(name);
    }
    if (name.startsWith("assets")) {
      cache[name] = await Assert.read(name);
    }
    if (name.startsWith("lib/")) {
      cache[name] = await Assert.read("js/$name");
    }
    return cache[name];
  }


  Future<String> _request(String url) async {
        try {
            Uri uri = Uri.parse(url);
            File file = await Path.jsByName(uri.pathSegments.last);
            bool fileExists = await file.exists();
            if (fileExists) {
              return Path.readByDir(file);
            }
            var response = await http.get(uri);
            if (response.statusCode != 200){
              return "";
            }else{
            bool cache = "127.0.0.1" != uri.host;
            if (cache){
              Path.write(file,response.bodyBytes);
            } 

              return response.body;
            }
          
        } catch (e) {
            e.toString();
            return "";
        }
    }
  // void bb(String content) {
  //     Uint8List bytes = base64.decode(content);
  //   }
}
