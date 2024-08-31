/*
 * @File     : jar_loader.dart
 * @Author   : jade
 * @Date     : 2024/8/23 下午5:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'dart:io';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/utils/url_util.dart';
import 'package:drama_source_core/src/api/Decoder.dart';
import 'package:ok_http/requests/ok_http.dart';


class JarLoader {
     late Map<String, dynamic> _loaders;
     late Map<String, dynamic> _methods;
     late Map<String, Spider> _spiders;
     late String recent;

     JarLoader() {
        _loaders = {};
        _methods = {};
        _spiders = {};
    }

     void clear() {
        for (Spider spider in _spiders.values) spider.destroy();
        _loaders.clear();
        _methods.clear();
        _spiders.clear();
    }

     void setRecent(String recent) {
        this.recent = recent;
    }

     void _load(String key, FileSystemEntity file) {

    }

     void _invokeInit(String key) {
        try {

        } catch (e) {

        }
    }

     void _putProxy(String key) {

    }

     Future<FileSystemEntity> _download(String url) async {
        try {
            return Path.write(await Path.jar(name: url),str: await OkHttp.instance.getText(url));
        } catch (e) {
            return await Path.jar(name: url);
        }
    }

     Future <void> parseJar(String key, String jar) async {
        if (_loaders.containsKey(key)) return;
        List<String> texts = jar.split(";md5;");
        String md5 = texts.length > 1 ? texts[1].trim() : "";
        jar = texts[0];
        if (md5.length > 0 && await Util.equals(jar, md5)) {
            _load(key,await Path.jar(name: jar));
        } else if (jar.startsWith("img+")) {
            _load(key, await Decoder.getSpider(jar));
        } else if (jar.startsWith("http")) {
            _load(key, await _download(jar));
        } else if (jar.startsWith("file")) {
            _load(key, await Path.local(jar));
        } else if (jar.startsWith("assets")) {
            await parseJar(key, await UrlUtil.convert(jar));
        } else if (!jar.isEmpty) {
            await parseJar(key,await UrlUtil.convert(jar));
        }
    }

      getLoader(String key, String jar) {
        if (!_loaders.containsKey(key)) parseJar(key, jar);
        return _loaders[key];
    }

    //  Spider getSpider(String key, String api, String ext, String jar) {
    //     try {
    //         String jaKey = Util.md5(jar);
    //         String spKey = jaKey + key;
    //         if (_spiders.containsKey(spKey)) return _spiders.get(spKey);
    //         if (!_spiders.containsKey(jaKey)) parseJar(jaKey, jar);
    //         Spider spider =_spiders.get(jaKey).loadClass("com.github.catvod.spider." + api.split("csp_")[1]).newInstance();
    //         spider.init(App.get(), ext);
    //         _spiders.put(spKey, spider);
    //         return spider;
    //     } catch (e,stackTrace) {
    //         Log.e(e.toString(), stackTrace);
    //         return new SpiderNull();
    //     }
    // }
    //
    //  JSONObject jsonExt(String key, LinkedHashMap<String, String> jxs, String url) throws Throwable {
    //     Class<?> clz = loaders.get("").loadClass("com.github.catvod.parser.Json" + key);
    //     Method method = clz.getMethod("parse", LinkedHashMap.class, String.class);
    //     return (JSONObject) method.invoke(null, jxs, url);
    // }
    //
    //  JSONObject jsonExtMix(String flag, String key, String name, LinkedHashMap<String, HashMap<String, String>> jxs, String url) throws Throwable {
    //     Class<?> clz = loaders.get("").loadClass("com.github.catvod.parser.Mix" + key);
    //     Method method = clz.getMethod("parse", LinkedHashMap.class, String.class, String.class, String.class);
    //     return (JSONObject) method.invoke(null, jxs, name, flag, url);
    // }

    //  Future <dynamic>? proxyInvoke(Map<String, String> params) {
    //     try {
    //         Method method = _methods[Util.md5(recent)];
    //         if (method == null) return null;
    //         return method.invoke(null, params);
    //     } catch (e,stackTrace) {
    //         Log.e(e.toString(), stackTrace);
    //         return null;
    //     }
    // }
}
