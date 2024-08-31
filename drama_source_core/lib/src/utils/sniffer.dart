/*
 * @File     : sniffer.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午4:35
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/drama_source_core.dart';

class Sniffer {

  static final RegExp CLICKER = RegExp("\\[a=cr:(\\{.*?\\})\\/](.*?)\\[\\/a]");
  static final RegExp AI_PUSH = RegExp("(http|https|rtmp|rtsp|smb|ftp|thunder|magnet|ed2k|mitv|tvbox-xg|jianpian|video):[^\\s]+", multiLine: true);
  static final RegExp SNIFFER = RegExp("http((?!http).){12,}?\\.(m3u8|mp4|mkv|flv|mp3|m4a|aac|mpd)\\?.*|http((?!http).){12,}\\.(m3u8|mp4|mkv|flv|mp3|m4a|aac|mpd)|http((?!http).)*?video/tos*|http((?!http).)*?obj/tos*");
  static final RegExp THUNDER = RegExp("(magnet|thunder|ed2k):.*");

  static bool isThunder(String url) {
    return CLICKER.hasMatch(url) || isTorrent(url);
  }

  static bool isTorrent(String url) {
    return !url.startsWith("magnet") && url.split(";")[0].endsWith(".torrent");
  }

  static String getUrl(String text) {
    if (Json.valid(text)) return text;
    Iterable<RegExpMatch> matches = AI_PUSH.allMatches(text);
    if (matches.first.groupCount > 0) return matches.first.group(0)!;
    return text;
  }

  static bool isVideoFormat(String url) {
    Rule rule = getRule(UrlUtil.uri(url));
    for (String exclude in rule.getExclude()) if (url.contains(exclude)) return false;
    for (String exclude in rule.getExclude()) if (RegExp(exclude).hasMatch(url)) return false;
    for (String regex in rule.getRegex()) if (url.contains(regex)) return true;
    for (String regex in rule.getRegex()) if (RegExp(regex).hasMatch(url)) return true;
    if (url.contains("url=http") || url.contains("v=http") || url.contains(".css") || url.contains(".html")) return false;
    return SNIFFER.hasMatch(url);
  }

  static Rule getRule(Uri uri) {
    if (uri.host.isEmpty) return Rule.empty();
    String hosts = UrlUtil.host(uri: uri) + "," + UrlUtil.host(url: uri.queryParameters["url"]);
    for (Rule rule in VodConfig. get ().getRules()) for (String host in rule.getHosts()) if (Util.containOrMatch(hosts, host)) return rule;
    return Rule.empty();
  }

  static List<String> getRegex(Uri uri) {
    return getRule(uri).getRegex();
  }

  static List<String> getScript(Uri uri) {
    return getRule(uri).getScript();
  }
}
