import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class NWApi {
  static final baseApi = "https://api.isoyu.com/api";
  static final news =
      "/News/new_list"; //接口返回：{"code": int, "message": "String", "data": {"account": "String", "password": "String"}}
  static final weather = "/Weather/get_weather";
  static final picture = "/picture/index";
}

class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class DioUtil {
  static final DioUtil _instance = DioUtil._init();
  static Dio _dio;
  static BaseOptions _options = getDefOptions();

  factory DioUtil() {
    return _instance;
  }

  DioUtil._init() {
    _dio = new Dio();
  }

  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.connectTimeout = 10 * 10000;
    options.receiveTimeout = 20 * 10000;
    // options.contentType = ContentType.parse('application/x-www-form-urlencoded');

    Map<String, dynamic> headers = Map<String, dynamic>();
    headers['Accept'] = 'application/json';

    String platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "IOS";
    }
    headers['OS'] = platform;
    options.headers = headers;

    return options;
  }

  setOptions(BaseOptions options) {
    _options = options;
    _dio.options = _options;
  }

  Future<Map<String, dynamic>> get(String path,
      {pathParams, data, Function errorCallback}) {
    return request(path,
        method: Method.get,
        pathParams: pathParams,
        data: data,
        errorCallback: errorCallback);
  }

  Future<Map<String, dynamic>> post(String path,
      {pathParams, data, Function errorCallback}) {
    return request(path,
        method: Method.post,
        pathParams: pathParams,
        data: data,
        errorCallback: errorCallback);
  }

  Future<Map<String, dynamic>> request(String path,
      {String method, Map pathParams, data, Function errorCallback}) async {
    ///restful请求处理 对
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        if (path.indexOf(key) != -1) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    }

    Response response = await _dio.request(NWApi.baseApi + path,
        data: data,
        queryParameters: pathParams,
        options: Options(method: method));
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          return response.data;
        } else {
          return json.decode(response.data.toString());
        }
      } catch (e) {
        return null;
      }
    } else {
      _handleHttpError(response.statusCode);
      if (errorCallback != null) {
        errorCallback(response.statusCode);
      }
      return null;
    }
  }

  ///处理Http错误码
  void _handleHttpError(int errorCode) {}
}
