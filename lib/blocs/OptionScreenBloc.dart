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
import 'package:geolocator_platform_interface/src/models/position.dart';

class OptionScreenBloc extends BaseModel implements ResponseListener {
  SharedPrefs? sharedPrefs;
  late ApiMethod webServiceMethod;
  BuildContext? context;
  GeneralResponseModel? generalResponseModel;
  String? url = '',
      mobileNumber = "",
      exdate = "",
      mfgdate = "",
      batchNo = "",
      uniqueData = "";

  TextEditingController serialController = TextEditingController();

  OptionScreenBloc(BuildContext context) {
    webServiceMethod = ApiMethod(this, context);
    sharedPrefs = SharedPrefs();
  }

  setUrl(String? scanData) {
    this.url = scanData;
    notifyListeners();
  }

  void setExData(String data3) {
    this.exdate = data3;
    notifyListeners();
  }

  void setMfgData(String data2) {
    this.mfgdate = data2;
    notifyListeners();
  }

  void setBatchData(String data1) {
    this.batchNo = data1;
    notifyListeners();
  }

  void setUniqueData(String data) {
    this.uniqueData = data;
    notifyListeners();
  }

  void progressEvent(bool isStart){
    setBusy(isStart);
  }

  getUrlFromStricker(
    String stricker,
    Position? currentLocation,
  ) async {
    setBusy(true);
    Map map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
    map['LanguageId'] = "1";
    map['MobileNo'] = "";
    map['Latitude'] = currentLocation != null ? currentLocation.latitude.toString() : "";
    map['Longitude'] = currentLocation != null ? currentLocation.longitude.toString() : "";
    map['StickerNo'] = stricker;
    map['ScanType'] = "";
    map['Action'] = Constant.Action_GetProductInfoLink;
    print('map:::$map');
    await webServiceMethod.post(Constant.Farmer_Scanning, body: map);
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
      if (methodName == Constant.Farmer_Scanning) {
        generalResponseModel = GeneralResponseModel.fromJsonStatus(
            json.decode(response.toString().trim()));
      }
    } finally {
      setBusy(false);
    }
  }
}
