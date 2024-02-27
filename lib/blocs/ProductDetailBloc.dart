import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/BaseModel.dart';
import 'package:flutter_basf_hk_app/model/GeneralResponseModel.dart';
import 'package:flutter_basf_hk_app/webservices/ApiMethod.dart';
import 'package:flutter_basf_hk_app/webservices/ResponseListener.dart';

class ProductDetailBloc extends BaseModel implements ResponseListener {
  SharedPrefs? sharedPrefs;
  ApiMethod? webServiceMethod;
  BuildContext? context;
  GeneralResponseModel? responseModel;
  String mobileNumber = "";

  TextEditingController mobileController = TextEditingController();

  ProductDetailBloc(BuildContext context) {
    webServiceMethod = ApiMethod(this, context);
    sharedPrefs = SharedPrefs();
  }

  @override
  void onFailure(String methodName, String errorTxt) {
    setBusy(false);
    Utils.showToastMessage(errorTxt);
  }

  @override
  Future<void> onSuccess(String methodName, response) async {
    try {
      responseModel = GeneralResponseModel.fromJsonStatus(
          json.decode(response.toString().trim()));
    } finally {
      setBusy(false);
    }
  }
}
