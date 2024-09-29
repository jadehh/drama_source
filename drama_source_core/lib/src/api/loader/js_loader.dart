/*
 * @File     : js_loader.dart
 * @Author   : jade
 * @Date     : 2024/08/22 09:55:06
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:quick_js/quick_js.dart' as QuickJs;

class JsLoader {
  late final Map<String, Spider> _spiders;
  late String _recent;

  JsLoader() {
    _spiders = {};
  }

  void clear() {
    for (Spider spider in _spiders.values) {
      spider.destroy();
    }
    _spiders.clear();
  }

  Future<Spider> getSpider(String key, String api, String ext) async {
    try {
      if (_spiders.containsKey(key))  return _spiders[key]!;
      Spider spider = QuickJs.Spider(key, api) as Spider;
      await spider.init(ext);
      _spiders[key] = spider;
      return spider;
    } catch (e,stackTrace) {
      Log.e(e.toString(), stackTrace);
      return SpiderNull();
    }
  }

  void setRecent(String recent) {
    this._recent = recent;
  }

  Future<Spider?> _find(Map<String, String> params) async {
    if (!params.containsKey("siteKey")) return _spiders[_recent];
    Site site = VodConfig.get().getSite(params["siteKey"]!);
    return site.isEmpty() ? new SpiderNull() : await VodConfig.get().getSpider(site);
    }

 Future <dynamic>? proxyInvoke(Map<String, String> params) async {
    try {
      Spider? spider = await _find(params);
      return spider!.proxyLocal(params);
    } catch (e,stackTrace) {
      Log.e(e.toString(), stackTrace);
      return null;
    }
  }
}
