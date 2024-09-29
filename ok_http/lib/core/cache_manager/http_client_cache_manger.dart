/*
 * @File     : http_client_cache_manger.dart
 * @Author   : jade
 * @Date     : 2024/9/27 11:14
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */


import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ok_http/core/cache_manager/file_manager_system.dart';
import 'package:ok_http/ok_http.dart';
import 'package:ok_http/core/cache_manager/http_client_manage_service.dart';


class HttpClientCacheManger extends CacheManager {
  static const key = 'NetImageCache';

  static late final HttpClientCacheManger _instance;

  static HttpClientCacheManger get instance => _instance;

  static void initialize(OkHttp okhttp) {
    _instance = HttpClientCacheManger._(okhttp);
  }
  HttpClientCacheManger._(OkHttp okhttp) : super(Config(key, fileService: HttpClientManageService(okhttp),fileSystem: FileManagerSystem(key)));
}
