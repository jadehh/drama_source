/*
 * @Author: jadehh
 * @Date: 2024-08-20 18:45:49
 * @LastEditTime: 2024-08-21 20:43:47
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\Decoder.dart
 * 
 */
import 'dart:convert';
import 'dart:io';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:cat_vod/cat_vod.dart';
import 'package:encrypt/encrypt.dart';
import 'package:convert/convert.dart';
import 'package:ok_http/ok_http.dart';

class Decoder {
  static Future<String> getJson(String url) async {
    String key = url.contains(";") ? url.split(";")[2] : "";
    url = url.contains(";") ? url.split(";")[0] : url;
    String data = await _getData(url);
    if (data.isEmpty) throw Exception("数据为空:检查${url}");
    if (Json.valid(data)) return await _fix(url, data);
    if (data.contains("**")) data = _base64(data);
    if (data.startsWith("2423")) data = await _cbc(data);
    if (key.length > 0) data = await _ecb(data, key);
    return await _fix(url, data);
  }

  static Future<String> _cbc(String data) async {
    String decode = String.fromCharCodes(hex.decode(data)).toLowerCase();
    String key = _padEnd(
        decode.substring(decode.indexOf(r"$#") + 2, decode.indexOf(r"#$")));
    String iv = _padEnd(decode.substring(decode.length - 13));
    final encrypter =
        Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc, padding: "PKCS5"));
    return encrypter.decrypt(Encrypted.fromUtf8(data), iv: IV.fromUtf8(iv));
  }

  static Future<String> _ecb(String data, String key) async {
    final encrypter =
        Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb, padding: "PKCS5"));
    return encrypter.decrypt(Encrypted.fromUtf8(data));
  }

  static String _padEnd(String key) {
    return key + "0000000000000000".substring(key.length);
  }

  static String _base64(String data) {
    String extract = _extract(data);
    if (extract.isEmpty) return data;
    return utf8.decode(base64.decode(extract));
  }

  static String _extract(String data) {
    final RegExp regExp = RegExp(r"[A-Za-z0-9]{8}\\*\\*");
    Iterable<RegExpMatch> matches = regExp.allMatches(data);
    return matches.isEmpty ? data.substring(matches.first.start + 10) : "";
  }

  static Future<String> _fix(String url, String data) async {
    if (url.startsWith("file") || url.startsWith("assets")) url = await UrlUtil.convert(url);
    if (data.contains("../")) data = data.replaceAll("../",  UrlUtil.resolve(url, "../"));
    if (data.contains("./")) data = data.replaceAll("./",  UrlUtil.resolve(url, "./"));
    return data;
  }

  static Future<FileSystemEntity> getSpider(String url) async{
        try {
            FileSystemEntity file = Path.jar(name: url);
            String data = _extract(await _getData(url.substring(4)));
            return data.isEmpty ? file: await Path.write(file, str: _base64(data));
        } catch (e) {
            return  Path.jar(name: url);
        }
    }


  static Future<String> _getData(String url) async {
    try {
      if (url.startsWith("file")) return await Path.read(path: url);
      if (url.startsWith("assets")) return await Asset.read(url);
      if (url.startsWith("http")) return await OkHttp.instance.getJson(url);
      return "";
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getExt(String _ext) async {
    try {
      return _base64(await _getData(_ext.substring(4)));
    } catch (e) {
      return "";
    }
  }



}
