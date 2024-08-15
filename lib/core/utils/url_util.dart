/*
 * @Author: jadehh
 * @Date: 2024-08-15 17:00:35
 * @LastEditTime: 2024-08-15 17:00:37
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\core\utils\url_util.dart
 * 
 */
class UrlUtil {
  static String fixUrl(String url) {
    if (url.contains("/localhost/")) url = url.replaceFirst("/localhost/", "/");
    if (url.startsWith("clan")) url = url.replaceFirst("clan", "file");
    return url;
  }
}
