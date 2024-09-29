import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'custom_log_interceptor.dart';
import 'http_error.dart';

class OkHttp {
  static OkHttp? _httpUtil;
  static final String getApi = "http://127.0.0.1:9999/api/v1/get";
  static final String postApi = "http://127.0.0.1:9999/api/v1/post";

  static OkHttp get instance {
    _httpUtil ??= OkHttp();
    return _httpUtil!;
  }

  late Dio dio;
  OkHttp() {
    dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 20), receiveTimeout: const Duration(seconds: 20), sendTimeout: const Duration(seconds: 20),),);
    // dio.httpClientAdapter = IOHttpClientAdapter()..onHttpClientCreate = (client) {
    //   // Config the client.
    //   client.findProxy = (uri) {
    //     // Forward all request to proxy "localhost:8888".
    //     return 'PROXY 127.0.0.1:7890';
    //   };
    //   // You can also create a new HttpClient for Dio instead of returning,
    //   // but a client must being returned here.
    //   return client;
    // };
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
    header ??= {};
    var options =  Options(responseType: ResponseType.plain, headers: header);
    try{
      var result = await requests("get", url, options,queryParameters: queryParameters,cancel: cancel);
      return result.data;
    }catch(e){
      throw e;
    }
  }

    /// Get请求，返回String
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<Uint8List> getData(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? header, CancelToken? cancel,}) async {
    header ??= {};
    var options = Options(responseType: ResponseType.bytes, headers: header);
    try{
      var result = await requests("get", url,queryParameters: queryParameters, options,cancel: cancel);
      return result.data;
    }catch(e){
      throw e;
    }
  }

  /// Get请求，返回Map
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<dynamic> getJson(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? header, CancelToken? cancel,}) async {
    header ??= {};
    var options = Options(
      responseType: ResponseType.json,
      headers: header,
    );
    try{
      var result = await requests("get", url,options,queryParameters: queryParameters,cancel: cancel);
      return result.data.toString();
    }catch(e){
      throw e;
    }
  }

  /// Get请求，返回Response
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<Response<dynamic>> get(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? header, CancelToken? cancel, Options? options, int maxRetries = 3}) async {
    queryParameters ??= {};
    header ??= {};
    options ??= Options(
      responseType: ResponseType.json,
      headers: header,
    );
    return await requests("get", url, options,queryParameters: queryParameters,cancel: cancel);
  }
   Future<Response<dynamic>> req(String url, Map<String,dynamic> opt) async {
     var data = opt.containsKey("data")  ? opt["data"] : {};
     var postType = opt.containsKey("postType") ? opt["postType"] : null;
     var method = opt.containsKey("method")? opt["method"]:"get";
     var buffer = opt.containsKey("buffer")  ? opt["buffer"] : 0;
     var redirect = opt.containsKey("redicet") ? true:false;
     var headers = opt.containsKey("headers") ? opt["headers"]:{};
     var respType = buffer == 0 ? ResponseType.json:ResponseType.bytes;
     if (postType == 'form') {
       headers['Content-Type'] = 'application/x-www-form-urlencoded';
       if (data != null) {
         data = jsonEncode(data);
       }
     } else if (postType == 'form-data') {
       headers['Content-Type'] = 'multipart/form-data';
       data = FormData.fromMap(data);
     }
     var options = Options(
         responseType: respType,
         headers: headers,
         followRedirects: redirect
     );
     return  await requests(method, url, options, data: data);
  }

  Future<Response<dynamic>> requests(String method,String url,Options options,{Object? data,Map<String,dynamic>? queryParameters, CancelToken? cancel,int maxRetries = 3, int retryDelay = 1000 }) async{
    int attempt = 0;
    while(true){
      try{
        if (method == "get"){
          return  await dio.get(url,options: options,data: data,queryParameters: queryParameters,cancelToken: cancel);
        }else if (method == "post"){
          return  await dio.post(url,options: options,data: data,queryParameters: queryParameters,cancelToken: cancel);
        }
        throw HttpError("暂不支持${method}方法");
      }catch (e) {
        if (attempt < maxRetries) {
          // 等待一段时间后重试
          await Future.delayed(Duration(milliseconds: retryDelay));
          attempt++;
        } else {
          if (e is DioException && e.type == DioExceptionType.badResponse) {
            throw HttpError(e.message ?? "",statusCode: e.response?.statusCode ?? 0);
          } else {
            throw HttpError("发送GET请求失败");
          }
        } // 重试次数已用完，抛出异常
      }
    }
    }
}
