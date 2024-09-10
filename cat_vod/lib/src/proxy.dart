/*
 * @File     : proxy.dart
 * @Author   : jade
 * @Date     : 2024/9/9 15:42
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:cat_vod/src/utils/util.dart';

class Proxy {

   static int port = 9978;

   static void set(int port) {
    Proxy.port = port;
  }

   static int getPort() {
    return port;
  }

   static Future<String> getUrl(bool local) async {
    return "http://" + (local ? "127.0.0.1" : await Util.getIp()) + ":" + getPort().toString() + "/proxy";
  }
}
