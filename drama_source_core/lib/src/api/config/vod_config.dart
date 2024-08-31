/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:00:12
 * @LastEditTime: 2024-08-22 15:03:23
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\api\config\vod_config.dart
 * 
 */


import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/api/decoder.dart' as DDecoder;
import 'package:drama_source_core/src/api/bean/depot.dart';
import 'package:drama_source_core/src/api/bean/k_parse.dart';
import 'package:drama_source_core/src/api/loader/jar_loader.dart';
import 'package:drama_source_core/src/api/loader/js_loader.dart';
import 'package:drama_source_log/drama_source_log.dart';

class VodConfig {
  late List<Doh>? _doh;

  late List<Rule>? _rules;

  late List<Site>? _sites;

  late List<KParse>? _parses;

  late List<String>? _flags;

  late List<String>? _ads;

  late JarLoader? _jarLoader;

  late JsLoader? _jsLoader;

  late bool? _loadLive;

  late Config? _config;

  late KParse? _parse;

  late String? _wall;

  late Site? _home;

  static final VodConfig _instance = VodConfig._internal();

  static VodConfig get instance => _instance;

  factory VodConfig() {
    return _instance;
  }

  VodConfig._internal() {
    // 初始化所有变量
    _wall = null;
    _home = null;
    _parse = null;
    _config = null;
    _ads = null;
    _doh = null;
    _rules = null;
    _sites = null;
    _flags = null;
    _parses = null;
    _jsLoader =  null;
    _jarLoader = null;
    _loadLive = null;

  }

  static VodConfig get() {
    return _instance;
  }

  static Future<int> getCid() async {
    return (await get().getConfig()).getId();
  }

  static Future<String?> getUrl() async{
    return (await get().getConfig()).getUrl();
  }

  static Future<String> getDesc() async {
    return (await get().getConfig()).getDesc();
  }

  static int? getHomeIndex() {
    return get().getSites().indexOf(get().getHome());
  }

  static bool hasParse() {
    return get().getParses().length > 0;
  }

  static Future<void> sLoad(Config config, Callback callback) async {
    await get().clear().config(config).load(callback: callback);
  }

  Future<VodConfig> init() async {
    _wall = null;
    _home = null;
    _parse = null;
    _config = await Config.vod();
    _ads = [];
    _doh = [];
    _rules = [];
    _sites = [];
    _flags = [];
    _parses = [];
    _jsLoader =  JsLoader();
    _jarLoader = JarLoader();
    _loadLive = false;
    return this;
  }

  VodConfig config(Config config) {
    _config = config;
    return this;
  }

  VodConfig clear() {
    _wall = null;
    _home = null;
    _parse = null;
    _ads!.clear();
    _doh!.clear();
    _rules!.clear();
    _sites!.clear();
    _flags!.clear();
    _parses!.clear();
    _jsLoader!.clear();
    _loadLive = true;
    return this;
  }


  load({required Callback callback, bool cache = false}) async {
    if (cache) await _loadConfigCache(callback);
    else await _loadConfig(callback);
  }

  _loadConfig(Callback callback) async {
    try {
      await _checkJson(Json.parse(await DDecoder.Decoder.getJson(_config!.getUrl()!)), callback);
    } catch (e, stackTrace) {
      if (TextUtils.isEmpty(_config!.getUrl())) callback.error("");
      else await _loadCache(callback, e);
      Log.e(e.toString(), stackTrace);
    }
  }

   _loadCache(Callback callback, Object e) async{
    if (!TextUtils.isEmpty(_config!.getJson())) await _checkJson(Json.parse(_config!.getJson()!), callback);
    else callback.error(Notify.getError(Local.error_config_get, e));
  }

  _loadConfigCache(Callback callback) async {
    if (!TextUtils.isEmpty(_config!.getJson())  && _config!.isCache()) await _checkJson(Json.parse(_config!.getJson()!), callback);
     else await _loadConfig(callback);
  }

   _checkJson(Map<String, dynamic> object, Callback callback) async {
    if (object.containsKey("msg")) callback.error(object["msg"].getAsString());
    else if (object.containsKey("urls")) await _parseDepot(object, callback);
    else await parseConfig(object, callback);
  }

  _parseDepot(Map<String, dynamic> object, Callback callback) async {
    List<Depot> items = Depot.arrayFrom(object["urls"]);
    List<Config> configs = [];
    for (Depot item in items) {
      Config? configItem = await Config.find(depot: item, type: 0);
      if (configItem != null) configs.add(configItem);
    }
    Config.delete(url: _config!.getUrl());
    _config = configs[0];
    _loadConfig(callback);
  }

  parseConfig(Map<String, dynamic> object, Callback callback) async {
    try {
      await _initSite(object);
      _initParse(object);
      _initOther(object);
      if (_loadLive! && object.containsKey("lives")) await _initLive(object);
      await _jarLoader!.parseJar("", Json.safeString(object, "spider"));
      _config!.logo(Json.safeString(object, "logo"));
      _config!.json(object.toString()).update();
      callback.success();
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace);
      callback.error(Notify.getError(Local.error_config_parse, e));
    }
  }

  _initSite(Map<String, dynamic> object) async {
    if (object.containsKey("video")) {
      await _initSite(object["video"]);
      return;
    }
    for (var element in object["sites"]) {
      Site site = Site.fromJson(element);
      if (_sites!.contains(site)) continue;
      site.setApi(await _parseApi(site.getApi()));
      site.setExt(await _parseExt(site.getExt()));
      _sites!.add(await site.trans().sync());
    }
    for (Site site in _sites!) {
      if (site.getKey() == (_config!.getHome())) {
        setHome(site);
      }
    }
  }

   _initLive(Map<String, dynamic> object) async{
    Config temp = await (await Config.find(config: _config,type: 1))!.save() ;
    bool sync = LiveConfig.get().needSync(_config!.getUrl()!);
    if (sync) (await LiveConfig.get().clear().config(temp)).parse(object);
  }

  void _initParse(Map<String, dynamic> object) {
    for (var element in object["parses"]) {
      KParse parse = KParse.fromJson(element);
      if (parse.getName() == (_config!.getParse()) && parse.getType() > 1) setParse(parse);
      if (!_parses!.contains(parse)) _parses!.add(parse);
    }
  }

  void _initOther(Map<String, dynamic> object ) {
        if (_parses!.length > 0) _parses![0] =  KParse.god();
        if (_home == null) setHome(_sites!.isEmpty ?  Site() : _sites![0]);
        if (_parse == null) setParse(_parses!.isEmpty ?  KParse() : _parses![0]);
        setRules(Rule.arrayFrom(object["rules"]));
        setDoh(Doh.arrayFrom(object["doh"]));
        setFlags(Json.safeListString(object, "flags"));
        _setWall(Json.safeString(object, "wallpaper"));
        setAds(Json.safeListString(object, "ads"));
    }

  Future<String> _parseApi(String _api) async {
    if (_api.startsWith("file") || _api.startsWith("clan") || _api.startsWith("assets")) return await UrlUtil.convert(_api);
    return _api;
  }

  Future<String> _parseExt(String _ext) async {
    if (_ext.startsWith("file") || _ext.startsWith("clan") || _ext.startsWith("assets")) return await UrlUtil.convert(_ext);
    if (_ext.startsWith("img+")) return await DDecoder.Decoder.getExt(_ext);
    return _ext;
  }

  Future<Spider> getSpider(Site site) async {
        bool js = site.getApi().contains(".js");
        if (js) return (await _jsLoader!.getSpider(site.getKey(), site.getApi(), site.getExt()))!;
        else return new SpiderNull();
    }

    void setRecent(Site site) {
        bool js = site.getApi().contains(".js");
        if (js) _jsLoader!.setRecent(site.getKey());
    }


     Future<dynamic> proxyLocal(Map<String, String> params) async{
        if ("js" == params["do"]) {
            return await _jsLoader!.proxyInvoke(params);
        }else{
          return null;
        }
    }

     List<Doh> getDoh() {
        List<Doh> items = Doh.get();
        if (_doh!.isEmpty) return items;
        for (var ele in _doh!){
             items.remove(ele);
        }
        items.addAll(_doh!);
        return items;
    }

     void setDoh(List<Doh> doh) {
        this._doh = doh;
    }

     List<Rule> getRules() {
        return _rules!;
    }

     void setRules(List<Rule> rules) {
        for (Rule rule in rules) if ("proxy" == rule.getName()){
           // OkHttp.selector().setHosts(rule.getHosts()); 设置所有请求的Doh
        }
        rules.remove(Rule.create("proxy"));
        this._rules = rules;
    }

     List<Site> getSites() {
        return _sites!;
    }

     List<KParse> getParses({int? type,String? flag}) {
      if (type!=null && flag == null){
        List<KParse> items = [];
        for (KParse item in getParses()) if (item.getType() == type) items.add(item);
        return items;
      }else if (type != null && flag != null){
        List<KParse> items = [];
        for (KParse item in getParses(type: type)) if (item.getExt().getFlag().isEmpty || item.getExt().getFlag().contains(flag)) items.add(item);
        if (items.isEmpty) items.addAll(getParses(type: type));
        return items;
      }else return _parses!;
    }

     List<String> getFlags() {
        return _flags!;
    }

     void setFlags(List<String> flags) {
        this._flags!.addAll(flags);
    }

     List<String> getAds() {
        return _ads!;
    }

     void setAds(List<String> ads) {
        this._ads = ads;
    }

     Future<Config> getConfig() async {
       return _config == null ? await Config.vod() : _config!;
    }

    KParse? getParse({String? name}) {
      if (name != null) {
        int index = getParses().indexOf(KParse.get(name: name));
        return index == -1 ? null : getParses()[index];
      }
      return _parse == null ?  KParse() : _parse!;
    }

     Site getHome() {
        return _home == null ?  Site() : _home!;
    }

     String getWall() {
        return TextUtils.isEmpty(_wall) ? "" : _wall!;
    }


     Site getSite(String key) {
        int index = getSites().indexOf(Site.get(key: key));
        return index == -1 ?  Site() : getSites()[index];
    }

     void setParse(KParse parse) {
        this._parse = parse;
        this._parse!.setActivated(activated: true);
        _config!.parse(parse.getName()).save();
        for (KParse item in getParses()) item.setActivated(item: parse);
    }

     void setHome(Site home) {
        this._home = home;
        this._home!.setActivated(activated: true);
        _config!.home(home.getKey()).save();
        for (Site item in getSites()) item.setActivated(item: home);
    }

     Future _setWall(String wall) async {
        this._wall = wall;
        bool load = !TextUtils.isEmpty(wall) && WallConfig.get().needSync(wall);
        if (load) WallConfig.get().config(await (await Config.find(url: wall, name: _config!.getName(), type:  2))!.update());
    }
}
