/*
 * @File     : live_parse.dart
 * @Author   : jade
 * @Date     : 2024/8/28 下午1:47
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:drama_source_core/src/api/Setting.dart';
import 'package:drama_source_core/src/api/bean/catch_up.dart';
import 'package:drama_source_core/src/api/bean/channel.dart';
import 'package:drama_source_core/src/api/bean/group.dart';
import 'package:drama_source_core/src/api/bean/live.dart';

class LiveParser {
  static final RegExp CATCHUP_SOURCE =
      RegExp(".*catchup-source=\"(.?|.+?)\".*");
  static final RegExp CATCHUP = RegExp(".*catchup=\"(.?|.+?)\".*");
  static final RegExp TVG_NAME = RegExp(".*tvg-name=\"(.?|.+?)\".*");
  static final RegExp TVG_LOGO = RegExp(".*tvg-logo=\"(.?|.+?)\".*");
  static final RegExp TVG_URL = RegExp(".*x-tvg-url=\"(.?|.+?)\".*");

  static final RegExp GROUP = RegExp(".*group-title=\"(.?|.+?)\".*");
  static final RegExp NAME = RegExp(r".*,(.+?)$");

  static String _extract(String line, RegExp regexp) {
    Iterable<RegExpMatch> matcher = regexp.allMatches(line);
    if (matcher.isNotEmpty) return matcher.first.group(1)!;
    return "";
  }

  static void text(Live live, String text) {
    int number = 0;
    if (live.getGroups().length > 0) return;
    text = text.replaceAll("\r\n", "\n");
    if (text.contains("#EXTM3U"))
      _m3u(live, text);
    else
      _txt(live, text);
    for (Group group in live.getGroups()) {
      for (Channel channel in group.getChannel()) {
        number = number + 1;
        channel.setNumber(number: number);
        channel.live(live);
      }
    }
  }

  static void _txt(Live live, String text) {
    Setting setting = Setting.create();
    for (String line in text.split("\n")) {
      List<String> split = line.split(",");
      int index = line.indexOf(",") + 1;
      if (setting.find(line)) setting.check(line);
      if (line.contains("#genre#")) setting.clear();
      if (line.contains("#genre#"))
        live.getGroups().add(Group.create(name: split[0], pass: live.isPass()));
      if (split.length > 1 && live.getGroups().isEmpty)
        live.getGroups().add(Group.create());
      if (split.length > 1 && split[1].contains("://")) {
        Group group = live.getGroups()[live.getGroups().length - 1];
        Channel channel = group.cfind(Channel.create(name: split[0])!);
        channel.addUrls(line.substring(index).split("#"));
        setting.copy(channel);
      }
    }
  }

  static void _m3u(Live live, String text) {
    Setting setting = Setting.create();
    Catchup catchup = Catchup.create();
    Channel? channel = Channel.create(name: "");
    for (String line in text.split("\n")) {
      if (setting.find(line)) {
        setting.check(line);
      } else if (line.startsWith("#EXTM3U")) {
        catchup.setType(_extract(line, CATCHUP));
        catchup.setSource(_extract(line, CATCHUP_SOURCE));
        if (live.getEpg().isEmpty) live.setEpg(_extract(line, TVG_URL));
      } else if (line.startsWith("#EXTINF:")) {
        Group group = live.gfind(
            Group.create(name: _extract(line, GROUP), pass: live.isPass()));
        channel = group.cfind(Channel.create(name: _extract(line, NAME))!);
        channel.setTvgName(_extract(line, TVG_NAME));
        channel.setLogo(_extract(line, TVG_LOGO));
        Catchup unknown = Catchup.create();
        unknown.setType(_extract(line, CATCHUP));
        unknown.setSource(_extract(line, CATCHUP_SOURCE));
        channel.setCatchup(Catchup.decide(unknown, catchup)!);
      } else if (!line.startsWith("#") && line.contains("://")) {
        List<String> split = line.split("\\|");
        if (split.length > 1) setting.headers(params: split);
        channel!.getUrls().add(split[0]);
        setting.copy(channel).clear();
      }
    }
  }
}
