/*
 * @Author: jadehh
 * @Date: 2024-08-15 17:00:35
 * @LastEditTime: 2024-08-21 09:22:43
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\utils\url_util.dart
 * 
 */
import 'package:drama_source_core/src/service/sync_service.dart';

class UrlUtil {
  static String fixUrl(String url) {
    if (url.contains("/localhost/")) url = url.replaceAll("/localhost/", "/");
    if (url.startsWith("clan")) url = url.replaceAll("clan", "file");
    return url;
  }

  static String scheme(String url) {
    return url.isEmpty ? "" : schemeByUri(Uri.parse(url));
  }

  static String schemeByUri(Uri uri) {
    String scheme = uri.scheme;
    return scheme.isEmpty ? "" : scheme.toLowerCase().trim();
  }

  static Future<String> convert(String url) async {
    String schemeStr = scheme(url);
    if ("clan" == schemeStr) return convert(fixUrl(url));
    if ("local" == schemeStr)
      return url.replaceAll(
          "local://", await SyncService.get().getAddressByPath(""));
    if ("assets" == schemeStr)
      return url.replaceAll(
          "assets://", await SyncService.get().getAddressByPath(""));
    if ("file" == schemeStr)
      return url.replaceAll(
          "file://", await SyncService.get().getAddressByPath("file/"));
    if ("proxy" == schemeStr)
      return url.replaceAll(
          "proxy://", await SyncService.get().getAddressByPath("proxy?"));
    return url;
  }

  static Future<String> resolve(String baseUri, String referenceUri) async {
   return uri(baseUri).resolve(referenceUri).toString();
  }

  static Uri uri(String url) {
    return Uri.parse(url.trim().replaceAll("\\", ""));
  }

  static String host({String? url, Uri? uri}) {
    if (uri != null) {
      String host = uri.host;
      return host.isEmpty ? "" : host.toLowerCase().trim();
    }
    if (url != null) {
      return host(uri: Uri.parse(url));
    }
    return "";
  }
}
