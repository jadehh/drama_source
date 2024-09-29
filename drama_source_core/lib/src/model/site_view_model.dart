/*
 * @File     : site_mode.dart
 * @Author   : jade
 * @Date     : 2024/8/30 下午12:44
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:convert';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:ok_http/requests/ok_http.dart';

class SiteViewModel {
  late String? key;
  SiteViewModel() {}
  Future<Result> homeContent() async {
    Site site =  VodConfig.get().getHome();
    key = site.getKey();
    if (site.getType() == 3) {
      Spider spider = await VodConfig.get().getSpider(site);
      String homeContent = await spider.homeContent(true);
      Log.SpiderDebug(homeContent);
      VodConfig.get().setRecent(site);
      Result result = Result.fromJson(Json.parse(homeContent));
      if (result.getList().length > 0) return result;
      String homeVideoContent = await spider.homeVideoContent();
      Log.SpiderDebug(homeVideoContent);
      result.setList(Result.fromJson(Json.parse(homeVideoContent)).getList());
      return result;
    } else if (site.getType() == 4) {
      Map<String, String> params = {};
      params["filter"] = "true";
      String homeContent = await _call(site, params, false);
      Log.SpiderDebug(homeContent);
      return Result.fromJson(Json.parse(homeContent));
    } else {
      try {
        String homeContent = await OkHttp.instance.getText(site.getApi(), header: site.getHeaders());
        Log.SpiderDebug(homeContent);
        return _fetchPic(site, Result.fromType(site.getType(), homeContent));
      } catch (e, stackTrace) {
        Log.e(e.toString(), stackTrace);
        return Result();
      }
    }
  }


  Future<String> _call(Site site, Map<String, String> params, bool limit) async {
    return (await _fetchExt(site, params, limit)).length <= 1000 ? await OkHttp.instance.getText(site.getApi(), queryParameters: params, header: site.getHeaders()) : "";
  }

  Future<String> _fetchExt(Site site, Map<String, String> params, bool limit) async {
    String extend = site.getExt();
    if (extend.startsWith("http")) {
      String response = await OkHttp.instance.getText(site.getExt(), header: site.getHeaders());
      if (response.isEmpty) return "";
      site.setExt(response);
      return site.getExt();
    }
    if (limit && extend.length > 1000) extend = extend.substring(0, 1000);
    if (!extend.isEmpty) params["extend"] = extend;
    return extend;
  }

  Future<Result> _fetchPic(Site site, Result result) async {
    if (site.getType() > 2 || result.getList().isEmpty || result.getList()[0].getVodPic().length > 0) return result;
    List<String> ids = [];
    if (site.getCategories().isEmpty) for (Vod item in result.getList()) ids.add(item.getVodId());
    else for (Vod item in result.getList()) if (site.getCategories().contains(item.getTypeName())) ids.add(item.getVodId());
    if (ids.isEmpty) return result.clear();
    Map<String, String> params = {};
    params["ac"] = site.getType() == 0 ? "videolist" : "detail";
    params["ids"] = ids.join(",");
    String response = await OkHttp.instance.getText(site.getApi(), header: site.getHeaders(), queryParameters: params);
    result.setList(Result.fromType(site.getType(), response).getList());
    return result;
  }

  Future<Result> categoryContent(String tid, String page, bool filter, Map<String, dynamic> extend) async {
    Site site = VodConfig.get().getSite(this.key!);
    if (site.getType() == 3) {
      Spider spider = await VodConfig.get().getSpider(site);
      String categoryContent = await spider.categoryContent(tid, page, filter, extend);
      Log.SpiderDebug(categoryContent);
      VodConfig.get().setRecent(site);
      return Result.fromJson(Json.parse(categoryContent));
    } else {
      Map<String, String> params = {};
      if (site.getType() == 1 && !extend.isEmpty) params["f"] = jsonEncode(extend);
      if (site.getType() == 4) params["ext"] = Util.base64ToStr(s: jsonEncode(extend));
      params["ac"] =  site.getType() == 0 ? "videolist" : "detail";
      params["t"] = tid;
      params["pg"] = page;
      String categoryContent = await _call(site,params,true);
      Log.SpiderDebug(categoryContent);
      return Result.fromType(site.getType(), categoryContent);
    }
  }

}
