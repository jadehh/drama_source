/*
 * @File     : flag.dart
 * @Author   : jade
 * @Date     : 2024/8/27 下午3:47
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:cat_vod/cat_vod.dart';
import 'package:drama_source_core/src/api/bean/episode.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprintf/sprintf.dart';

part 'flag.g.dart';

@JsonSerializable()
class Flag {

  @JsonKey(name: "flag")
  late String? j_flag;

  @JsonKey(name: "show")
  late String? j_show;

  @JsonKey(name: "urls")
  late String? j_urls;

  @JsonKey(name: "episodes")
  late List<Episode>? j_episodes;

  @JsonKey(name: "activated")
  late bool? j_activated;

  @JsonKey(name: "position")
  late int? j_position;

  Flag({String? flag, String? show, String? urls, bool activated = false, int position = -1}) {
    this.j_flag = flag;
    if (show != null) this.j_show = Trans.s2t(text: show);
    else this.j_show = show;
    this.j_urls = urls;
    this.j_episodes = [];
    this.j_activated = activated;
    this.j_position = position;
  }

  factory Flag.fromJson(Map<String, dynamic> json) => _$FlagFromJson(json);

  Map<String, dynamic> toJson() => _$FlagToJson(this);


  static Flag create(String flag) {
    return new Flag(flag: flag);
  }

  String getShow() {
    return TextUtils.isEmpty(j_show) ? getFlag() : j_show!;
  }

  String getFlag() {
    return TextUtils.isEmpty(j_flag) ? "" : j_flag!;
  }

  String? getUrls() {
    return j_urls;
  }

  List<Episode> getEpisodes() {
    return j_episodes!;
  }

  bool isActivated() {
    return j_activated!;
  }

  void setActivated(Flag item) {
    this.j_activated = item.equals(this);
    if (j_activated!) item.j_episodes = j_episodes;
  }

  int getPosition() {
    return j_position!;
  }

  void setPosition(int position) {
    this.j_position = position;
  }

  void createEpisode(String data) {
    List<String> urls = data.contains("#") ? data.split("#") : [data];
    for (int i = 0; i < urls.length; i++) {
      List<String> split = urls[i].split(r"\\$");
      String number = sprintf( "{Platform.localeName}%02d", i + 1);
      Episode episode = split.length > 1 ? Episode.create(name:split[0].isEmpty ? number : split[0].trim(), url:split[1]) : Episode.create(name: number, url:urls[i]);
      if (!getEpisodes().contains(episode)) getEpisodes().add(episode);
    }
  }

  void toggle(bool activated, Episode episode) {
    if (activated)
      _setActivated(episode);
    else
      for (Episode item in getEpisodes()) item.deactivated();
  }



  void _setActivated(Episode episode) {
    setPosition(getEpisodes().indexOf(episode));
    for (int i = 0; i < getEpisodes().length; i++)
      getEpisodes()[i].setActivated(i == getPosition());
  }

  Episode? find(String remarks, bool strict) {
    int number = Util.getDigit(remarks);
    if (getEpisodes().length == 0) return null;
    if (getEpisodes().length == 1) return getEpisodes()[0];
    for (Episode item in getEpisodes()) if (item.rule1(remarks)) return item;
    for (Episode item in getEpisodes()) if (item.rule2(number)) return item;
    if (number == -1) for (Episode item in getEpisodes()) if (item.rule3(remarks)) return item;
    if (number == -1) for (Episode item in getEpisodes()) if (item.rule4(remarks)) return item;
    if (getPosition() != -1) return getEpisodes()[getPosition()];
    return strict ? null : getEpisodes()[0];
  }

  static List<Flag> createList(String flag, String name, String url) {
    Flag item = Flag.create(flag);
    item.getEpisodes().add(Episode.create(name: name, url: url));
    return [item];
  }

  bool equals(Object obj) {
    if (this == obj) return true;
    if (!(obj is Flag)) return false;
    return getFlag() == obj.getFlag();
  }
}