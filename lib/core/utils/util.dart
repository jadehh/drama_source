/*
 * @File     : util.dart
 * @Author   : jade
 * @Date     : 2024/08/15 10:49:14
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

class Util {
  static int stringToInt(String input) {
    // 正则表达式匹配整数，包括负数和整数
    RegExp exp = RegExp(r'\d+');
    // 使用正则表达式查找所有匹配的整数
    Iterable<Match> matches = exp.allMatches(input);
    // 将匹配的字符串提取出来
    return int.parse(matches.map((match) => match.group(0)).join());
  }
}
