/*
 * @File     : http_client_manage_service.dart
 * @Author   : jade
 * @Date     : 2024/9/27 13:18
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ok_http/ok_http.dart';
import 'package:ok_http/core/cache_manager/mime_extension.dart';

class HttpClientManageService extends FileService {
  final OkHttp _okHttp;

  HttpClientManageService(this._okHttp);

  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) async {
    Options options = Options(headers: headers ?? {}, responseType: ResponseType.stream);
    Response<dynamic> httpResponse = await _okHttp.get(url,options: options,maxRetries: 5);
    return OkHttpGetResponse(httpResponse);
  }
}

class OkHttpGetResponse implements FileServiceResponse {
  final DateTime _receivedTime = DateTime.now();
  final Response<dynamic> _response;

  OkHttpGetResponse(this._response);

  @override
  Stream<List<int>> get content => _response.data!.stream;

  @override
  int get contentLength => _getContentLength();

  @override
  String get eTag => _response.headers['etag']?.first ?? '-1';

  @override
  String get fileExtension {
    var fileExtension = '';
    final contentTypeHeader = _response.headers[Headers.contentTypeHeader]?.first;
    if (contentTypeHeader != null) {
      final contentType = ContentType.parse(contentTypeHeader);
      fileExtension = mimeTypes[contentType.mimeType]!;
    }
    return fileExtension;
  }

  @override
  int get statusCode => _response.statusCode!;

  @override
  DateTime get validTill {
    // Without a cache-control header we keep the file for a week
    var ageDuration = const Duration(days: 7);
    final controlHeader = _response.headers['cache-control']?.first;
    if (controlHeader != null) {
      final controlSettings = controlHeader.split(',');
      for (final setting in controlSettings) {
        final sanitizedSetting = setting.trim().toLowerCase();
        if (sanitizedSetting == 'no-cache') {
          ageDuration = const Duration();
        }
        if (sanitizedSetting.startsWith('max-age=')) {
          var validSeconds = int.tryParse(sanitizedSetting.split('=')[1]) ?? 0;
          if (validSeconds > 0) {
            ageDuration = Duration(seconds: validSeconds);
          }
        }
      }
    }
    return _receivedTime.add(ageDuration);
  }

  int _getContentLength() {
    try {
      return int.parse(_response.headers[Headers.contentLengthHeader]?.first ?? '-1');
    } catch (e) {
      return -1;
    }
  }
}