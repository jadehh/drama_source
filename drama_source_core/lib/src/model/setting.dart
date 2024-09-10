/*
 * @Author: jadehh
 * @Date: 2024-08-19 11:12:20
 * @LastEditTime: 2024-08-22 13:03:05
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\model\setting.dart
 * 
 */

import 'dart:math';

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/player/Players.dart';

class Setting {
  static String getDoh() {
    return Prefers.getString("doh");
  }

  static Future putDoh(String doh) async {
    await Prefers.put("doh", doh);
  }

  static String getProxy() {
    return Prefers.getString("proxy");
  }

  static Future putProxy(String proxy) async{
    await Prefers.put("proxy", proxy);
  }

  static String getKeep() {
    return Prefers.getString("keep");
  }

  static Future putKeep(String keep) async{
    await Prefers.put("keep", keep);
  }

  static String getKeyword() {
    return Prefers.getString("keyword");
  }

  static Future putKeyword(String keyword) async{
    await Prefers.put("keyword", keyword);
  }

  static String getHot() {
    return Prefers.getString("hot");
  }

  static Future putHot(String hot) async {
    await Prefers.put("hot", hot);
  }

  static String getUa() {
    return Prefers.getString("ua");
  }

  static Future putUa(String ua) async {
    await Prefers.put("ua", ua);
  }

  static int getWall() {
    return Prefers.getInt("wall", defaultValue: 1);
  }

  static Future putWall(int wall) async {
    await Prefers.put("wall", wall);
  }

  static int getReset() {
    return Prefers.getInt("reset", defaultValue: 0);
  }

  static Future putReset(int reset) async{
    await Prefers.put("reset", reset);
  }

  static int getPlayer() {
    return Prefers.getInt("player", defaultValue: Players.EXO);
  }

  static Future putPlayer(int player) async {
    await Prefers.put("player", player);
  }

  static int getLivePlayer() {
    return Prefers.getInt("player_live", defaultValue: getPlayer());
  }

  static Future putLivePlayer(int player) async {
    await Prefers.put("player_live", player);
  }

  static int getDecode(int player) {
    return Prefers.getInt("decode_" + player.toString(), defaultValue: Players.HARD);
  }

  static Future putDecode(int player, int decode)async {
   await Prefers.put("decode_" + player.toString(), decode);
  }

  static int getRender() {
    return Prefers.getInt("render", defaultValue: 0);
  }

  static Future putRender(int render) async{
    await Prefers.put("render", render);
  }

  static int getQuality() {
    return Prefers.getInt("quality", defaultValue: 2);
  }

  static Future putQuality(int quality) async{
    await Prefers.put("quality", quality);
  }

  static int getSize() {
    return Prefers.getInt("size", defaultValue: 2);
  }

  static Future putSize(int size) async{
   await Prefers.put("size", size);
  }

  static int getViewType(int viewType) {
    return Prefers.getInt("viewType", defaultValue: viewType);
  }

  static Future putViewType(int viewType) async{
    await Prefers.put("viewType", viewType);
  }

  static int getScale() {
    return Prefers.getInt("scale");
  }

  static Future putScale(int scale) async{
    await Prefers.put("scale", scale);
  }

  static int getLiveScale() {
    return Prefers.getInt("scale_live", defaultValue: getScale());
  }

  static Future putLiveScale(int scale) async{
    await Prefers.put("scale_live", scale);
  }

  static int getSubtitle() {
    return min(max(Prefers.getInt("subtitle", defaultValue: 16), 14), 48);
  }

  static Future putSubtitle(int subtitle) async {
    await Prefers.put("subtitle", subtitle);
  }

  static int getHttp() {
    return Prefers.getInt("exo_http", defaultValue: 1);
  }

  static Future putHttp(int http) async {
    await Prefers.put("exo_http", http);
  }

  static int getBuffer() {
    return min(max(Prefers.getInt("exo_buffer"), 1), 15);
  }

  static Future putBuffer(int buffer) async {
    await Prefers.put("exo_buffer", buffer);
  }

  static int getFlag() {
    return Prefers.getInt("flag");
  }

  static Future putFlag(int flag) async {
    await Prefers.put("flag", flag);
  }

  static int getEpisode() {
    return Prefers.getInt("episode");
  }

  static Future putEpisode(int episode) async {
    await Prefers.put("episode", episode);
  }

  static int getBackground() {
    return Prefers.getInt("background", defaultValue: 2);
  }

  static Future putBackground(int background) async{
    await Prefers.put("background", background);
  }

  static int getRtsp() {
    return Prefers.getInt("rtsp");
  }

  static Future putRtsp(int rtsp) async{
    await Prefers.put("rtsp", rtsp);
  }

  static int getSiteMode() {
    return Prefers.getInt("site_mode", defaultValue: 1);
  }

  static Future putSiteMode(int mode) async {
    await Prefers.put("site_mode", mode);
  }

  static bool isBootLive() {
    return Prefers.getBoolean("boot_live");
  }

  static Future putBootLive(bool boot) async{
    await Prefers.put("boot_live", boot);
  }

  static bool isInvert() {
    return Prefers.getBoolean("invert");
  }

  static Future putInvert(bool invert) async{
    await Prefers.put("invert", invert);
  }

  static bool isAcross() {
    return Prefers.getBoolean("across", defaultValue: true);
  }

  static Future putAcross(bool across) async{
    await Prefers.put("across", across);
  }

  static bool isChange() {
    return Prefers.getBoolean("change", defaultValue: true);
  }

  static Future putChange(bool change) async {
    await Prefers.put("change", change);
  }

  static bool getUpdate() {
    return Prefers.getBoolean("update", defaultValue: true);
  }

  static Future putUpdate(bool update) async{
    await Prefers.put("update", update);
  }

  static bool isDanmu() {
    return Prefers.getBoolean("danmu");
  }

  static Future putDanmu(bool danmu) async{
    await Prefers.put("danmu", danmu);
  }

  static bool isDanmuLoad() {
    return Prefers.getBoolean("danmu_load", defaultValue: true);
  }

  static Future putDanmuLoad(bool load) async {
    await Prefers.put("danmu_load", load);
  }

  static int getDanmuSpeed() {
    return min(max(Prefers.getInt("danmu_speed", defaultValue: 2), 0), 3);
  }

  static Future putDanmuSpeed(int speed) async{
    await Prefers.put("danmu_speed", speed);
  }

  static double getDanmuSize() {
    return min(max(Prefers.getFloat("danmu_size", defaultValue: 1.0), 0.6), 2.0);
  }

  static Future putDanmuSize(double size) async{
    await Prefers.put("danmu_size", size);
  }

  static int getDanmuLine(int line) {
    return min(max(Prefers.getInt("danmu_line", defaultValue: line), 1), 15);
  }

  static Future putDanmuLine(int line) async {
    await Prefers.put("danmu_line", line);
  }

  static int getDanmuAlpha() {
    return min(max(Prefers.getInt("danmu_alpha", defaultValue: 90), 10), 100);
  }

  static Future putDanmuAlpha(int alpha) async {
    await Prefers.put("danmu_alpha", alpha);
  }

  static bool isCaption() {
    return Prefers.getBoolean("caption");
  }

  static Future putCaption(bool caption) async{
   await Prefers.put("caption", caption);
  }

  static bool isTunnel() {
    return Prefers.getBoolean("exo_tunnel");
  }

  static Future putTunnel(bool tunnel) async{
    await Prefers.put("exo_tunnel", tunnel);
  }

  static int getBackupMode() {
    return Prefers.getInt("backup_mode", defaultValue: 1);
  }

  static Future putBackupMode(int auto) async {
    await Prefers.put("backup_mode", auto);
  }

  static double getThumbnail() {
    return 0.3 * getQuality() + 0.4;
  }

  static bool isBackgroundOff() {
    return getBackground() == 0;
  }

  static bool isBackgroundOn() {
    return getBackground() == 1 || getBackground() == 2;
  }

  static bool isBackgroundPiP() {
    return getBackground() == 2;
  }

  //  static bool hasCaption() {
  //     return Settings.ACTION_CAPTIONING_SETTINGS
  //     return new Intent().resolveActivity(App.get().getPackageManager()) != null;
  // }

  static bool isDisplayTime() {
    return Prefers.getBoolean("display_time", defaultValue: false);
  }

  static Future putDisplayTime(bool display) async{
   await Prefers.put("display_time", display);
  }

  static bool isDisplaySpeed() {
    return Prefers.getBoolean("display_speed", defaultValue: false);
  }

  static Future putDisplaySpeed(bool display) async{
   await Prefers.put("display_speed", display);
  }

  static bool isDisplayDuration() {
    return Prefers.getBoolean("display_duration", defaultValue: false);
  }

  static Future putDisplayDuration(bool display) async {
    await Prefers.put("display_duration", display);
  }

  static bool isDisplayMiniProgress() {
    return Prefers.getBoolean("display_mini_progress", defaultValue: false);
  }

  static Future putDisplayMiniProgress(bool display) async {
    await Prefers.put("display_mini_progress", display);
  }

  static bool isDisplayVideoTitle() {
    return Prefers.getBoolean("display_video_title", defaultValue: false);
  }

  static Future putDisplayVideoTitle(bool display) async {
   await Prefers.put("display_video_title", display);
  }

  static double getPlaySpeed() {
    return Prefers.getFloat("play_speed", defaultValue: 1.0);
  }

  static Future putPlaySpeed(double speed) async {
   await Prefers.put("play_speed", speed);
  }

  static Future putFullscreenMenuKey(int key) async {
   await Prefers.put("fullscreen_menu_key", key);
  }

  static int getFullscreenMenuKey() {
    return Prefers.getInt("fullscreen_menu_key", defaultValue: 0);
  }

  static Future putHomeMenuKey(int key) async {
    await Prefers.put("home_menu_key", key);
  }

  static int getHomeMenuKey() {
    return Prefers.getInt("home_menu_key", defaultValue: 0);
  }

  static bool isHomeSiteLock() {
    return Prefers.getBoolean("home_site_lock", defaultValue: false);
  }

  static Future putHomeSiteLock(bool lock) async {
    await Prefers.put("home_site_lock", lock);
  }

  static bool isIncognito() {
    return Prefers.getBoolean("incognito");
  }

  static Future putIncognito(bool incognito) async {
   await Prefers.put("incognito", incognito);
  }

  static Future putSmallWindowBackKey(int key) async {
    await Prefers.put("small_window_back_key", key);
  }

  static int getSmallWindowBackKey() {
    return Prefers.getInt("small_window_back_key", defaultValue: 0);
  }

  static Future putHomeDisplayName(bool change) async {
    await Prefers.put("home_display_name", change);
  }

  static bool isHomeDisplayName() {
    return Prefers.getBoolean("home_display_name", defaultValue: false);
  }

  static bool isAggregatedSearch() {
    return Prefers.getBoolean("aggregated_search", defaultValue: false);
  }

  static Future putAggregatedSearch(bool search) async {
    await Prefers.put("aggregated_search", search);
  }

  static Future putHomeUI(int key) async {
    await Prefers.put("home_ui", key);
  }

  static int getHomeUI() {
    return Prefers.getInt("home_ui", defaultValue: 1);
  }

  static Future putHomeButtons(String buttons) async {
   await Prefers.put("home_buttons", buttons);
  }

  static String getHomeButtons(String defaultValue) {
    return Prefers.getString("home_buttons", defaultValue: defaultValue);
  }

  static Future putHomeButtonsSorted(String buttons) async {
    await Prefers.put("home_buttons_sorted", buttons);
  }

  static String getHomeButtonsSorted(String defaultValue) {
    return Prefers.getString("home_buttons_sorted", defaultValue: defaultValue);
  }

  static bool isHomeHistory() {
    return Prefers.getBoolean("home_history", defaultValue: true);
  }

  static Future putHomeHistory(bool show) async {
    await Prefers.put("home_history", show);
  }

  static Future putConfigCache(int key) async {
   await Prefers.put("config_cache", key);
  }

  static int getConfigCache() {
    return min(Prefers.getInt("config_cache", defaultValue: 0), 2);
  }

  static Future putLanguage(int key) async {
    await Prefers.put("language", key);
  }

  static int getLanguage() {
    return Prefers.getInt("language", defaultValue: 0);
  }

  static Future putParseWebView(int key) async {
    await Prefers.put("parse_webview", key);
  }

  static int getParseWebView() {
    return Prefers.getInt("parse_webview", defaultValue: 0);
  }

  static bool isRemoveAd() {
    return Prefers.getBoolean("remove_ad", defaultValue: false);
  }

  static Future putRemoveAd(bool remove) async {
    await Prefers.put("remove_ad", remove);
  }

  static String getThunderCacheDir() {
    return Prefers.getString("thunder_cache_dir", defaultValue: "");
  }

  static Future putThunderCacheDir(String dir) async {
    await Prefers.put("thunder_cache_dir", dir);
  }

  static Future putVersion(String version) async {
   await Prefers.put("version", version);
  }

  static int getTheme() {
    return Prefers.getInt("theme",defaultValue: 0);
  }

  static bool getFirstRun() {
    return Prefers.getBoolean("firstRun",defaultValue: true);
  }

  static Future putFirstRun() async {
    await Prefers.put("firstRun", false);
  }

  static int getScaleModel() {
    return Prefers.getInt("scaleMode",defaultValue: 0);
  }

  static bool getLogEnable() {
    return Prefers.getBoolean("logEnable",defaultValue: true);
  }

  static  putApplicationSupportDirectory(String path) async {
    await Prefers.put("application_support_directory", path);
  }

  static String getApplicationSupportDirectory(){
    return Prefers.getString("application_support_directory",defaultValue: "");
  }

  static putApplicationCacheDirectory(String path) async{
    await Prefers.put("application_cache_directory", path);
  }

  static String getApplicationCacheDirectory(){
    return Prefers.getString("application_cache_directory",defaultValue: "");
  }

  static putApplicationDocumentsDirectory(String path) async{
    await Prefers.put("application_documents_directory",path);
  }

  static String getApplicationDocumentsDirectory(){
    return Prefers.getString("application_documents_directory",defaultValue: "");
  }

  static putDownloadsDirectory(String? path) async{
    await Prefers.put("downloads_directory",path);
  }

  static String getDownloadsDirectory(){
    return Prefers.getString("downloads_directory",defaultValue: "");
  }

  static putLibraryDirectory(String path) async{
    await Prefers.put("library_directory",path);
  }

  static String getLibraryDirectory(){
    return Prefers.getString("library_directory",defaultValue: "");
  }

  static putTemporaryDirectory(String path) async {
    await Prefers.put("temporary_directory",path);
  }

  static String getTemporaryDirectory(){
    return Prefers.getString("temporary_directory",defaultValue: "");
  }

  static putExternalStorageDirectory(String path) async{
    await Prefers.put("external_storage_directory",path);
  }

  static String getExternalStorageDirectory(){
    return Prefers.getString("external_storage_directory",defaultValue: "");
  }
}
