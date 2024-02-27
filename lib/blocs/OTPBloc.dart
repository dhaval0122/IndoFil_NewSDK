import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/BaseModel.dart';
import 'package:flutter_basf_hk_app/model/GeneralResponseModel.dart';
import 'package:flutter_basf_hk_app/webservices/ApiMethod.dart';
import 'package:flutter_basf_hk_app/webservices/ResponseListener.dart';

import '../webservices/Constant.dart';

class OTPBloc extends BaseModel implements ResponseListener {
  SharedPrefs? sharedPrefs;
  ApiMethod? webServiceMethod;
  BuildContext? context;
  GeneralResponseModel? responseModel;
  String mobileNumber = "", action = '';
  bool isLoading = false;

  TextEditingController mobileController = TextEditingController();

  OTPBloc(BuildContext context) {
    webServiceMethod = ApiMethod(this, context);
    sharedPrefs = SharedPrefs();
  }

  Future<void> callVerifyAPI(String mobileNo, String pin) async {
    setBusy(true);
    var map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
    map[Constant.Action] = Constant.Action_VerifyOTP;
    map['varMobile'] = mobileNo;
    map['varEmail'] = '';
    map['varPurpose'] = 'CustomerRegistration';
    map['varOTP'] = pin;
    print('map:::$map');
    action = Constant.Action_VerifyOTP;
    await webServiceMethod!.post(Constant.MobileOREmailVerify, body: map);
  }

  Future<void> OTPGenerate(String mobileNo) async {
    setBusy(true);
    var map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
    map[Constant.Action] = Constant.Action_OTPGenerate;
    map['varMobile'] = mobileNo;
    map['varEmail'] = '';
    map['varPurpose'] = 'CustomerRegistration';
    map['varOTP'] = '';
    print('map:::$map');
    action = Constant.Action_OTPGenerate;
    await webServiceMethod!.post(Constant.MobileOREmailVerify, body: map);
  }

  @override
  void onFailure(String methodName, String errorTxt) {
    setBusy(false);
    Utils.showToastMessage(errorTxt);
  }

  @override
  Future<void> onSuccess(String methodName, response) async {
    try {
      if (action == Constant.Action_VerifyOTP) {
        responseModel = GeneralResponseModel.fromJsonStatus(
            json.decode(response.toString().trim()));
      } else if (action == Constant.Action_OTPGenerate) {
        responseModel = GeneralResponseModel.fromJsonStatus(
            json.decode(response.toString().trim()));
      }
    } finally {
      setBusy(false);
    }
  }
}
