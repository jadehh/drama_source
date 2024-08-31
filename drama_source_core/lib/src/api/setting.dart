/*
 * @File     : Setting.dart
 * @Author   : jade
 * @Date     : 2024/8/28 下午1:52
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/channel.dart';
import 'package:drama_source_core/src/api/bean/clear_key.dart';
import 'package:drama_source_core/src/api/bean/drm.dart';
import 'package:drama_source_core/src/model/mime_types.dart';
import 'package:drama_source_core/src/player/Players.dart';

class Setting {
  late String? _ua;
  late String? _key;
  late String? _type;
  late String? _click;
  late String? _format;
  late String? _origin;
  late String? _referer;
  late int? _parse;
  late int? _player;
  late Map<String, String>? _header;

  static Setting create() {
    return Setting();
  }

  bool find(String line) {
    return line.startsWith("ua") || line.startsWith("parse") ||
        line.startsWith("click") || line.startsWith("player") ||
        line.startsWith("header") || line.startsWith("format") ||
        line.startsWith("origin") || line.startsWith("referer") ||
        line.startsWith("#EXTHTTP:") || line.startsWith("#EXTVLCOPT:") ||
        line.startsWith("#KODIPROP:");
  }

  void check(String line) {
    if (line.startsWith("ua"))
      ua(line);
    else if (line.startsWith("parse"))
      parse(line);
    else if (line.startsWith("click"))
      click(line);
    else if (line.startsWith("player"))
      player(line);
    else if (line.startsWith("header"))
      header(line);
    else if (line.startsWith("format"))
      format(line);
    else if (line.startsWith("origin"))
      origin(line);
    else if (line.startsWith("referer"))
      referer(line);
    else if (line.startsWith("#EXTHTTP:"))
      header(line);
    else if (line.startsWith("#EXTVLCOPT:http-origin"))
      origin(line);
    else if (line.startsWith("#EXTVLCOPT:http-user-agent"))
      ua(line);
    else if (line.startsWith("#EXTVLCOPT:http-referrer"))
      referer(line);
    else if (line.startsWith("#KODIPROP:inputstream.adaptive.license_key"))
      key(line);
    else if (line.startsWith("#KODIPROP:inputstream.adaptive.license_type"))
      type(line);
    else if (line.startsWith("#KODIPROP:inputstream.adaptive.manifest_type"))
      format(line);
    else if (line.startsWith("#KODIPROP:inputstream.adaptive.stream_headers")) headers(line: line);
  }

  Setting copy(Channel channel) {
    if (_ua != null) channel.setUa(_ua!);
    if (_parse != null) channel.setParse(_parse!);
    if (_click != null) channel.setClick(_click!);
    if (_format != null) channel.setFormat(_format!);
    if (_origin != null) channel.setOrigin(_origin!);
    if (_referer != null) channel.setReferer(_referer!);
    if (_player != null) channel.setPlayerType(_player!);
    if (_header != null) channel.setHeader(Json.toMap(json: _header));
    if (_key != null && _type != null) channel.setDrm(
        Drm.create(_key!, _type!));
    return this;
  }

  void ua(String line) {
    try {
      if (line.contains("user-agent="))
        _ua = line.split("(?i)user-agent=")[1].trim().replaceAll("\"", "");
      if (line.contains("ua="))
        _ua = line.split("ua=")[1].trim().replaceAll("\"", "");
    }
    catch (e) {
      _ua = null;
    }
  }

  void referer(String line) {
    try {
      _referer = line.split("(?i)referer=")[1].trim().replaceAll("\"", "");
    }
    catch (e) {
      _referer = null;
    }
  }

  void parse(String line) {
    try {
      _parse = int.parse(line.split("parse=")[1].trim());
    }
    catch (e) {
      _parse = null;
    }
  }

  void click(String line) {
    try {
      _click = line.split("click=")[1].trim();
    }
    catch (e) {
      _click = null;
    }
  }

  void player(String line) {
    try {
      _player = int.parse(line.split("player=")[1].trim());
    }
    catch (e) {
      _player = null;
    }
  }

  void format(String line) {
    try {
      if (line.startsWith("format=")) _format = line.split("format=")[1].trim();
      if (line.contains("manifest_type="))
        _format = line.split("manifest_type=")[1].trim();
      if ("mpd" == _format || "dash" == _format)
        _format = MimeTypes.APPLICATION_MPD;
      if ("hls" == _format) _format = MimeTypes.APPLICATION_M3U8;
    }
    catch (e) {
      _format = null;
    }
  }

  void origin(String line) {
    try {
      _origin = line.split("(?i)origin=")[1].trim();
    }
    catch (e) {
      _origin = null;
    }
  }

  void key(String line) {
    try {
      _key = line.split("license_key=")[1].trim();
      if (!_key!.startsWith("http")) convert();
    }
    catch (e) {
      _key = null;
    } finally {
      _player = Players.EXO;
    }
  }

  void type(String line) {
    try {
      _type = line.split("license_type=")[1].trim();
    }
    catch (e) {
      _type = null;
    } finally {
      _player = Players.EXO;
    }
  }

  void header(String line) {
    try {
      if (line.contains("#EXTHTTP:"))
        _header =
            Json.toMap(json: Json.parse(line.split("#EXTHTTP:")[1].trim()));
      if (line.contains("header="))
        _header = Json.toMap(json: Json.parse(line.split("header=")[1].trim()));
    }
    catch (e) {
      _header = null;
    }
  }

  void headers({String? line, List<String>? params}) {
    if (line != null) {
      try {
        headers(params: line.split("headers=")[1].trim().split("&"));
      }
      catch (e) {}
    }
    if (params != null) {
      if (_header == null) _header = {};
      for (String param in params) {
        List<String> a = param.split("=");
        _header![a[0].trim()] = a[1].trim().replaceAll("\"", "");
      }
    }
  }


  void convert() {
    try {
      ClearKey.fromJson(Json.parse(_key!));
    }
    catch
    (e) {
    _key = ClearKey.get(_key!.replaceAll("\"", "").replaceAll("{", "").replaceAll("}", "")).toString();
    }
  }

  void clear() {
    _ua = null;
    _key = null;
    _type = null;
    _parse = null;
    _click = null;
    _player = null;
    _header = null;
    _format = null;
    _origin = null;
    _referer = null;
  }
}