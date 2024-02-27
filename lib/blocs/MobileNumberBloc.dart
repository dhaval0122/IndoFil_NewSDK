import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/BaseModel.dart';
import 'package:flutter_basf_hk_app/model/GeneralResponseModel.dart';
import 'package:flutter_basf_hk_app/webservices/ApiMethod.dart';
import 'package:flutter_basf_hk_app/webservices/Constant.dart';
import 'package:flutter_basf_hk_app/webservices/ResponseListener.dart';

import '../model/MobileOREmailVerify.dart';

class MobileNumberBloc extends BaseModel implements ResponseListener {
  SharedPrefs? sharedPrefs;
  late ApiMethod webServiceMethod;
  BuildContext? context;
  GeneralResponseModel? checkUpdateResponseModel, generalResponseModel;
  String mobileNumber = '', action = '', oTPConfigTimer = '0';
  bool? isOTPConfig = false;

  TextEditingController mobileController = TextEditingController();

  List<MobileOREmailVerify> mobileOREmailVerify = <MobileOREmailVerify>[];

  MobileNumberBloc(BuildContext context) {
    webServiceMethod = ApiMethod(this, context);
    sharedPrefs = SharedPrefs();
    getMobileNumber();
  }

  getMobileNumber() async {
    mobileNumber = await sharedPrefs!.getString(PREF_Mobile);
    print("mobile number--" + mobileNumber);
    mobileController.text = mobileNumber;
    notifyListeners();
  }

  Future<void> checkConfigure() async {
    setBusy(true);
    var map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
    map[Constant.Action] = Constant.Action_Check2FA;
    map['varMobile'] = '';
    map['varEmail'] = '';
    map['varPurpose'] = '';
    map['varOTP'] = '';
    print('map:::$map');
    action = Constant.Action_Check2FA;

    await webServiceMethod.post(Constant.MobileOREmailVerify, body: map);
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
    await webServiceMethod.post(Constant.MobileOREmailVerify, body: map);
  }

  registerCall(String number, String Latitude, String Longitude) async {
    setBusy(true);
    var map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
    map['LanguageId'] = '1';
    map['MobileNo'] = number;
    map['Latitude'] = Latitude;
    map['Longitude'] = Longitude;
    map[Constant.Action] = Constant.action_Registration;
    print('map:::$map');
    await webServiceMethod.post(Constant.FarmerRegistration, body: map);
  }

  @override
  void onFailure(String methodName, String errorTxt) {
    setBusy(false);
    Utils.showToastMessage(errorTxt);
    generalResponseModel = null;
  }

  @override
  Future<void> onSuccess(String methodName, response) async {
    try {
      if (methodName == Constant.FarmerRegistration) {
        generalResponseModel = GeneralResponseModel.fromJsonStatus(
            json.decode(response.toString().trim()));
      } else if (methodName == Constant.MobileOREmailVerify) {
        if (action == Constant.Action_Check2FA) {
          generalResponseModel = GeneralResponseModel.fromJsonStatus(
              json.decode(response.toString().trim()));

          if (generalResponseModel!.response['mobileOREmailVerify'] != null) {
            mobileOREmailVerify.clear();
            generalResponseModel!.response['mobileOREmailVerify'].forEach((v) {
              mobileOREmailVerify.add(MobileOREmailVerify.fromJson(v));
            });
            if(mobileOREmailVerify.isNotEmpty){
              await sharedPrefs!.setString(
                  PREF_IS_SDK_SCAN_ENABLE,
                  mobileOREmailVerify[0].isSDKScanEnable!);
            }
          }
        } else {
          generalResponseModel = GeneralResponseModel.fromJsonStatus(
              json.decode(response.toString().trim()));
        }
      }
    } finally {
      setBusy(false);
    }
  }

  void setConfigure(bool isONOFF) {
    isOTPConfig = isONOFF;
    notifyListeners();
  }

  void setConfigureTimer(String timer) {
    oTPConfigTimer = timer;
    notifyListeners();
  }
}
