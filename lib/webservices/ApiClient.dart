import 'package:dio/dio.dart';
import 'package:flutter_basf_hk_app/webservices/Constant.dart';

import 'ResponseListener.dart';

class ApiClient {
  static final ApiClient _singleton = ApiClient._internal();

  Dio? dio;
  ResponseListener? responseListener;

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal();

  Dio? getDioObject(ResponseListener responseListener) {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = Constant.BASE_URL;
      dio!.options.connectTimeout = const Duration(seconds: 20);  // Updated
      dio!.options.receiveTimeout = const Duration(seconds: 30);  // Updated
      dio!.options.contentType = Headers.formUrlEncodedContentType;
      dio!.interceptors
          .add(LogInterceptor(responseBody: false, requestBody: true));
      responseListener = responseListener;
    }
    return dio;
  }
}
