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
import 'package:fluttertoast/fluttertoast.dart';

class ScanBloc extends BaseModel implements ResponseListener {
  SharedPrefs? sharedPrefs;
  late ApiMethod webServiceMethod;
  BuildContext? context;
  GeneralResponseModel? responseModel;
  bool isLoadData = false, isThirdParty = false;

  String? action = "",
      scanData = "",
      // http://www.ivcs.ai:8091/21/KAH18RO6/10/N_3?11=210330&17=210728
      // http://i.ivcs.ai:8091/21/KCID4OIC/10/CRBatch?11=211123&17=211127 IQA
      exdate = "",
      mfgdate = "",
      batchNo = "",
      uniqueData = "";

  ScanBloc(BuildContext context) {
    webServiceMethod = ApiMethod(this, context);
    sharedPrefs = SharedPrefs();
  }

  @override
  void onFailure(String methodName, String errorTxt) {
    setloading(false);
    setBusy(false);
    Fluttertoast.showToast(msg: errorTxt);
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

  void setloading(bool isLoadData) {
    this.isLoadData = isLoadData;
    notifyListeners();
  }

  scanAPI(String mobileNo, String stricker, String Latitude,
      String Longitude) async {
    setBusy(true);
    Map map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
    map['LanguageId'] = "1";
    map['MobileNo'] = mobileNo;
    map['Latitude'] = Latitude;
    map['Longitude'] = Longitude;
    map['StickerNo'] = stricker;
    map['QR_Code'] = "";
    map['ScanType'] = "D";
    map['Action'] = Constant.Action_Scanning;
    this.action = Constant.Action_Scanning;
    print('map:::$map');
    await webServiceMethod.post(Constant.Farmer_Scanning, body: map);
  }

  setScandata(String? scanData) {
    this.scanData = scanData;
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

  void setThirdParty(String s) {
    scanData = s;
    isThirdParty = s.isNotEmpty ? true : false;
    notifyListeners();
  }
}
