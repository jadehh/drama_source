import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'custom_log_interceptor.dart';
import 'http_error.dart';

class OkHttp {
  static OkHttp? _httpUtil;

  static OkHttp get instance {
    _httpUtil ??= OkHttp();
    return _httpUtil!;
  }

  late Dio dio;
  OkHttp() {
    dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 20), receiveTimeout: const Duration(seconds: 20), sendTimeout: const Duration(seconds: 20),),);
    dio.interceptors.add(CustomLogInterceptor());
  }

  /// Get请求，返回String
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<String> getText(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.get(url,
        queryParameters: queryParameters,
        options: Options(responseType: ResponseType.plain, headers: header,),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw HttpError(e.message ?? "",
            statusCode: e.response?.statusCode ?? 0);
      } else {
        throw HttpError("发送GET请求失败");
      }
    }
  }

    /// Get请求，返回String
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<Uint8List> getData(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.get(url,
        queryParameters: queryParameters,
        options: Options(responseType: ResponseType.bytes, headers: header,),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw HttpError(e.message ?? "",
            statusCode: e.response?.statusCode ?? 0);
      } else {
        throw HttpError("发送GET请求失败");
      }
    }
  }

  /// Get请求，返回Map
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<dynamic> getJson(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw HttpError(e.message ?? "",
            statusCode: e.response?.statusCode ?? 0);
      } else {
        throw HttpError("发送GET请求失败");
      }
    }
  }

  /// Get请求，返回Response
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
        ),
        cancelToken: cancel,
      );
      return result;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw HttpError(e.message ?? "",
            statusCode: e.response?.statusCode ?? 0);
      } else {
        throw HttpError("发送GET请求失败");
      }
    }
  }
   Future<Response<dynamic>> req(
    String url, Map<String,dynamic> opt
  ) async {
    try {
      var data = opt.containsKey("data")  ? opt["data"] : {};
      var postType = opt.containsKey("postType") ? opt["postType"] : null;
      var method = opt.containsKey("method")? opt["method"]:"get";
      var returnBuffer = opt.containsKey("returnBuffer")  ? opt["returnBuffer"] : 0;
      var redirect = opt.containsKey("redicet") ? true:false;
      var headers = opt.containsKey("headers") ? opt["headers"]:{};
      var respType = returnBuffer == 0 ? ResponseType.json:ResponseType.bytes;

      if (postType == 'form') {
            headers['Content-Type'] = 'application/x-www-form-urlencoded';
            if (data != null) {
              data = jsonEncode(data);
            }
        } else if (postType == 'form-data') {
            headers['Content-Type'] = 'multipart/form-data';
            data = FormData.fromMap(data);
      }
      if (method == "get"){
         var result = await dio.get(
        url,
        data: data,
        options: Options(
          responseType: respType,
          headers: headers,
          followRedirects: redirect
        ),
      );
         return result;
      }else{
        var result = await dio.post(url,data:data,options: Options(
          responseType: respType,
          headers: headers,
          followRedirects: redirect
        ));
        return result;
      }





    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw HttpError(e.message ?? "",
            statusCode: e.response?.statusCode ?? 0);
      } else {
        throw HttpError("发送GET请求失败");
      }
    }
  }


  /// Post请求，返回Map
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [data] 内容
  /// * [cancel] 任务取消Token
  Future<dynamic> postJson(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? header,
    bool formUrlEncoded = false,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      data ??= {};
      var result = await dio.post(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
          contentType:
              formUrlEncoded ? Headers.formUrlEncodedContentType : null,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw HttpError(e.message ?? "",
            statusCode: e.response?.statusCode ?? 0);
      } else {
        throw HttpError("发送POST请求失败");
      }
    }
  }

  /// Head请求，返回Response
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<Response> head(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.head(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: header,
          receiveDataWhenStatusError: true,
        ),
        cancelToken: cancel,
      );
      return result;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.badResponse) {
        return e.response!;
      } else {
        throw HttpError("发送HEAD请求失败");
      }
    }
  }
}
