import 'dart:async';
import 'dart:convert';
import 'dart:convert' show utf8;

import 'package:flutter/cupertino.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/webservices/Constant.dart';
import 'package:flutter_basf_hk_app/webservices/ResponseListener.dart';
import 'package:http/http.dart' as http;

class ApiMethod {
  late ResponseListener responseListener;
  BuildContext? context;
  static Map<String, String> headersValue = {
    'Content-Type': 'application/json',
    'X-ApiKey': 'i3BalYxQL'
  };

  ApiMethod(ResponseListener responseListener, BuildContext context) {
    this.responseListener = responseListener;
    this.context = context;
  }

  Future<dynamic> get(String methodName) async {
    String URL = Constant.BASE_URL + methodName;
    Future<dynamic> response;
    try {
      response = http
          .get(Uri.parse(URL), headers: headersValue)
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          responseListener.onFailure(
              methodName, Utils.getStatuscodeMsg(response.statusCode)!);
        }
      });
      return response;
    } catch (e) {
      responseListener.onFailure(
          methodName, LocaleUtils.getString(context, 'servernotrespond'));
    }
  }

  Future<dynamic> post(String methodName,
      {Map? headers, body, encoding}) async {
    String URL = Constant.BASE_URL + methodName;
    print('======URL====POST===$URL');
    try {
      final response = await http
          .post(Uri.parse(URL), body: jsonEncode(body), headers: headersValue)
          .timeout(Duration(minutes: 6))
          .catchError((onError) {
        responseListener.onFailure(
            methodName, LocaleUtils.getString(context, 'servernotrespond'));
      });
      if (response != null && response.statusCode == 200) {
        print('======response====== ' + utf8.decode(response.bodyBytes));
        try {
          Map<String, dynamic>? statusMap =
              json.decode(utf8.decode(response.bodyBytes));
          if (response.statusCode == 200) {
            responseListener.onSuccess(
                methodName, utf8.decode(response.bodyBytes));
            return response;
          } else {
            responseListener.onFailure(
                methodName, Utils.getStatuscodeMsg(response.statusCode)!);
          }
        } catch (e) {
          responseListener.onFailure(
              methodName, LocaleUtils.getString(context, 'servernotrespond'));
        }
      } else {
        print('==persistentConnection==2==${response.persistentConnection}');
        print('======response====== ${response.body}');
        responseListener.onFailure(
            methodName, LocaleUtils.getString(context, 'servernotrespond'));
        return null;
      }
    } on TimeoutException {
      responseListener.onFailure(
          methodName, LocaleUtils.getString(context, 'connetiontimeout'));
      return null;
    }
  }
}
