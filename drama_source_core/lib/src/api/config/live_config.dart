/*
 * @File     : live_config.dart
 * @Author   : jade
 * @Date     : 2024/8/27 上午9:07
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_core/src/api/bean/group.dart';
import 'package:drama_source_core/src/api/bean/channel.dart';
import 'package:drama_source_core/src/api/bean/depot.dart';
import 'package:drama_source_core/src/api/bean/keep.dart';
import 'package:drama_source_core/src/api/bean/live.dart';
import 'package:drama_source_core/src/api/decoder.dart' as DDecoder;
import 'package:drama_source_core/src/api/live_parse.dart';
import 'package:drama_source_core/src/model/db/app_database.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:get/get.dart';

class LiveConfig {
  late List<Live>? _lives;
  late Config? _config;
  late bool? _sync;
  late Live? _home;

  static final LiveConfig _instance = LiveConfig._internal();

  static LiveConfig get instance => _instance;

  factory LiveConfig() {
    return _instance;
  }

  LiveConfig._internal(){
    _lives = null;
    _sync = false;
  }

  static LiveConfig get() {
    return _instance;
  }

  static Future<String?> getUrl() async {
    return (await get().getConfig()).getUrl();
  }

  static Future<String> getDesc() async {
    return (await get().getConfig()).getDesc();
  }

  static String getResp() {
    return get().getHome().getCore().getResp();
  }

  static int getHomeIndex() {
    return get().getLives().indexOf(get().getHome());
  }

  static bool isOnly() {
    return get().getLives().length == 1;
  }

  static bool isEmpty() {
    return get().getHome().isEmpty();
  }

  static Future<bool> hasUrl() async {
    return await getUrl() != null && (await getUrl())!.length > 0;
  }

  static Future sload(Config config, Callback callback) async {
    (await get().clear().config(config)).load(callback: callback);
  }

  Future<LiveConfig> init() async {
    this._home = null;
    return await config(await Config.live());
  }

  Future<LiveConfig> config(Config config) async {
    this._config = config;
    if (config.getUrl() == null) return this;
    this._sync = config.getUrl() == await VodConfig.getUrl();
    return this;
  }

  LiveConfig clear() {
    getLives().clear();
    this._home = null;
    return this;
  }

  Future load({Callback? callback}) async{
    if (callback == null){
       if (isEmpty()) {
         await load(callback: Callback((){}, (String message){}));
       }
    }
    if (callback != null) await _loadConfig(callback);
  }

  Future _loadConfig(Callback? callback) async {
    try {
      await _parseConfig(text: await DDecoder.Decoder.getJson(_config!.getUrl()!), callback: callback);
    } catch (e, stackTrace) {
      if (TextUtils.isEmpty(_config!.getUrl())) callback!.error("");
      else callback!.error(Notify.getError(Local.error_config_get.tr, e));
      Log.e(e.toString(), stackTrace);
    }
  }

  Future _parseConfig({String? text, Map<String, dynamic>? object, Callback? callback}) async {
    if (text != null) {
      if (Json.invalid(text)) {
        await _parseText(text, callback);
      } else {
       await _checkJson(Json.parse(text), callback);
      }
    }
    if (object != null) {
      List<Map<String, dynamic>> lives = Json.safeListElement(object, "lives");
      if (lives.length > 0) for (Map<String, dynamic> element in lives) await _add(Live.fromJson(element).check());
      for (Live live in getLives()) if (live.getName() == _config!.getHome()) setHome(home: live, check: true);
      if (_home == null) setHome(home:getLives().isEmpty?  Live() : getLives()[0], check: true);
      if (callback != null) callback.success();
    }
  }

  Future _parseText(String text, Callback? callback) async {
    Live live = await Live(url: _config!.getUrl()!).sync();
    LiveParser.text(live, text);
    getLives().remove(live);
    getLives().add(live);
    setHome(home: live, check: true);
    callback!.success();
  }

  Future _checkJson(Map<String, dynamic> object, Callback? callback) async{
    if (object.containsKey("msg") && callback != null) {
      callback.error(object["msg"].toString());
    } else if (object.containsKey("urls")) {
      await _parseDepot(object, callback);
    } else {
      await _parseConfig(object: object, callback: callback);
    }
  }

  Future _parseDepot(Map<String, dynamic> object, Callback? callback) async {
    List<Depot> items = Depot.arrayFrom(object["urls"]);
    List<Config> configs = [];
    for (Depot item in items)
      configs.add((await Config.find(depot: item, type: 1))!);
    await Config.delete(url: _config!.getUrl());
    _config = configs[0];
    _loadConfig(callback);
  }

  Future _add(Live live) async{
    if (!getLives().contains(live)) getLives().add(await live.sync());
  }

  void _bootLive() {
    Setting.putBootLive(false);
    // LiveActivity.start(App.get());
  }

  Future parse(Map<String, dynamic> object) async{
    await _parseConfig(object: object, callback: null);
  }

  Future setKeep({Channel? channel, List<Group>? items}) async {
    if (channel != null) {
      if (_home == null || channel.getGroup()!.isHidden() || channel.getUrls().isEmpty)
        return await Setting.putKeep(_home!.getName() + AppDatabase.SYMBOL + channel.getGroup()!.getName() + AppDatabase.SYMBOL + channel.getName() + AppDatabase.SYMBOL + channel.getCurrent());
    }
    if (items != null) {
      List<String> key = [];
      for (Keep keep in (await Keep.getLive())!) key.add(keep.getKey());
      for (Group group in items) {
        if (group.isKeep()) continue;
        for (Channel channel in group.getChannel()) {
          if (key.contains(channel.getName())) {
            items[0].add(channel);
          }
        }
      }
    }
  }

  List<int> find(List<Group> items, {String? number}) {
    if (number != null) {
      for (int i = 0; i < items.length; i++) {
        int j = items[i].find(number: int.parse(number));
        if (j != -1) return [i, j];
      }
      return [-1, -1];
    } else {
      List<String> splits = Setting.getKeep().split(AppDatabase.SYMBOL);
      if (splits.length < 4 ||  getHome().getName() == splits[0])
        return [1, 0];
      for (int i = 0; i < items.length; i++) {
        Group group = items[i];
        if (group.getName() == splits[1]) {
          int j = group.find(name: splits[2]);
          if (j != -1 && splits.length == 4)
            group.getChannel()[j].setLine(lineStr: splits[3]);
          if (j != -1) return [i, j];
        }
      }
      return [1, 0];
    }
  }

  bool needSync(String url) {
    return _sync! || TextUtils.isEmpty(_config!.getUrl()) || url == _config!.getUrl();
  }

  List<Live> getLives() {
    return _lives == null ? _lives = [] : _lives!;
  }

  Future<Config> getConfig() async {
    return _config == null ? await Config.live() : _config!;
  }

  Live getHome() {
    return _home == null ? Live() : _home!;
  }

  Future setHome({required Live home, bool check = false}) async {
    _home = home;
    _home!.setActivated(activated: true);
    await _config?.home(home.getName()).update();
    for (Live item in getLives()) item.setActivated(item: home);
    if (check) if (home.isBoot() || Setting.isBootLive()) _bootLive();
  }
}
