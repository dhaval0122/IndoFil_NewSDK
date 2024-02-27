import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/components/CustomAppInfoDialog.dart';
import 'package:flutter_basf_hk_app/components/CustomLogoutAlertDialog.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/model/LoginResponseModel.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/webservices/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PermissionsService.dart';

class Utils {
  String DATE_WITH_TIME_SERVER_FORMAT = 'yyyy-MM-dd HH:mm:ss';
  String DATE_SERVER_FORMAT = 'yyyy-MM-dd';
  static String ALLOWED_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

//  Future<String> encryptPassword(String password, String synCode) {
//    return EcpSyncPlugin().encodeData(password, 'B4V2A1C@S#S\$F', synCode);
//  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    // ignore: deprecated_member_use
    return double.parse(s, ((e) => null) as double Function(String)?) != null ||
        // ignore: deprecated_member_use
        int.parse(s, onError: ((e) => null) as int Function(String)?) != null;
  }

//  Future<String> getMenufacturer() async {
//    String manufacturer = '';
//    try {
//      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//      if (Platform.isAndroid) {
//        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//        //print('*****menufacturer******:${androidInfo.manufacturer}');
//        manufacturer = androidInfo.manufacturer;
//      }
//    } on Exception {
//      print('Failed to get platform version');
//    }
//    return manufacturer;
//  }
//
//  Future<String> getDeviceID() async {
//    String deviceId = '';
//    try {
//      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//      if (Platform.isAndroid) {
//        //appType = 'android';
//        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//        //print('Running on Android:${androidInfo.androidId}');
//        deviceId = androidInfo.androidId;
//      } else if (Platform.isIOS) {
//        //appType = 'ios';
//        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//        //print('Running on IOS: ${iosInfo.identifierForVendor}');
//        deviceId = iosInfo.identifierForVendor;
//      }
//    } on Exception {
//      print('Failed to get platform version');
//    }
//    return deviceId;
//  }

  String getSerialNoFromBarcode(String barcode) {
    if (barcode.length <= 14) {
      return barcode;
    }
    String serialNo = '';
    final List<String> separated = barcode.split(' ');

    final String separated1 = separated[separated.length - 1];
    //String separated1 = separated[1];
    if (separated1.trim().isNotEmpty) {
      serialNo = separated1.substring(4);
    }
    return serialNo;
  }

  String convertDateTimeToString(var date, String formate) {
    final DateFormat formatter = DateFormat(formate);
    final String formatted = formatter.format(date);
    print(formatted);
    return formatted;
  }

  String convertDateFormat(var date, String formate) {
    return convertDateTimeToString(date, formate);
  }

  String convertDateTimeDisplay1(String date, String displayFormat) {
    final DateFormat displayFormater = DateFormat(DATE_WITH_TIME_SERVER_FORMAT);
    final DateFormat serverFormater = DateFormat(displayFormat);
    final DateTime displayDate = displayFormater.parseUTC(date);
    final String formatted = serverFormater.format(displayDate.toLocal());
    //print('===convertDateTime======formatted====$formatted');
    return formatted;
  }

  String convertDateTimeDisplay(String date, String displayFormat) {
    final DateFormat displayFormater = DateFormat('MM/dd/yyyy');
    final DateFormat serverFormater = DateFormat(displayFormat);
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    //print('===convertDateTime======formatted====$formatted');
    return formatted;
  }

  String getCurrentDateTime(String dateFormat) {
    final DateFormat displayFormater = DateFormat(dateFormat);
    final String formatted = displayFormater.format(DateTime.now());
    print('===getCurrentDateTime====$formatted');
    return formatted;
  }

//
//  bool check7DayBeforeSync(String date) {
//    final DateFormat displayFormater = DateFormat(
//        PROJECT_NAME == 'BASF_HK' ? 'MM/dd/yyyy HH:mm' : 'dd/MM/yyyy HH:mm');
//    DateTime currentDateTime = DateTime.now();
//    currentDateTime.add(Duration(minutes: globals.SyncAlertValue1));
//    final DateTime displayDate = displayFormater.parse(date);
//    return currentDateTime
//        .difference(displayDate)
//        .inMinutes >= globals.SyncAlertValue1 ? true : false;
//  }
//
//  DateTime getDateTimeNext7Day(String date, bool is7Day) {
//    final DateFormat displayFormater = DateFormat(
//        PROJECT_NAME == 'BASF_HK' ? 'MM/dd/yyyy HH:mm' : 'dd/MM/yyyy HH:mm');
//    DateTime currentDateTime = DateTime.now();
//    currentDateTime.add(Duration(minutes: is7Day ? globals.SyncAlertValue1 : globals.SyncAlertValue2));
//    final DateTime displayDate = displayFormater.parse(date);
//    return displayDate;
//  }
//
//  bool check1DayBeforeSync(String date) {
//    final DateFormat displayFormater = DateFormat(
//        PROJECT_NAME == 'BASF_HK' ? 'MM/dd/yyyy HH:mm:ss' : 'dd/MM/yyyy HH:mm:ss');
//    DateTime currentDateTime = DateTime.now();
//    //currentDateTime.add(Duration(minutes: globals.SyncAlertValue2));
//    final DateTime displayDate = displayFormater.parse(date);
//    return currentDateTime
//        .difference(displayDate)
//        .inMinutes >= globals.SyncAlertValue2 ? true : false;
//  }

//  bool check7DayBeforeSync(String date, String dateFormat) {
//    final DateFormat displayFormater = DateFormat(dateFormat);
//    final DateTime currentDateTime = DateTime.now();
//    currentDateTime.add(Duration(minutes: globals.SyncAlertValue1));
//    final DateTime displayDate = displayFormater.parse(date);
//    return currentDateTime
//        .difference(displayDate)
//        .inMinutes >= globals.SyncAlertValue1 ? true : false;
//  }

//  DateTime getDateTimeNext7Day(String date, bool is7Day, String dateFormat) {
//    final DateFormat displayFormater = DateFormat(dateFormat);
//    DateTime currentDateTime = DateTime.now();
//    currentDateTime.add(Duration(
//        minutes: is7Day ? globals.SyncAlertValue1 : globals.SyncAlertValue2));
//    final DateTime displayDate = displayFormater.parse(date);
//    return displayDate;
//  }

//  bool check1DayBeforeSync(String date, String dateFormat) {
//    print('===dateFormat===${dateFormat}');
//    print('===date===${date}');
//    DateFormat displayFormater = DateFormat(dateFormat);
//
//    DateTime displayDate1 = displayFormater.parse(date);
//    String formattedDate1 = displayFormater.format(displayDate1);
//    DateTime displayDate = displayFormater.parse(formattedDate1);
//
//    String formattedDate = displayFormater.format(DateTime.now());
//    DateTime currentDateTime = displayFormater.parse(formattedDate);
//
//    return currentDateTime
//        .difference(displayDate)
//        .inMinutes >= globals.SyncAlertValue2 ? true : false;
//  }

  String convertDateTime(String date, String displayFormat) {
    final DateFormat displayFormater = DateFormat(displayFormat);
    final DateFormat serverFormater = DateFormat(DATE_SERVER_FORMAT);
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    //print('===convertDateTime======formatted====$formatted');
    return formatted;
  }

  String getDateTimeFormat(
      DateTime datetime, String displaystring, String serverstring) {
    final DateFormat displayFormater = DateFormat(displaystring);
    final DateFormat serverFormater = DateFormat(serverstring);
    final DateTime displayDate = displayFormater.parse(datetime.toString());
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  DateTime getActualMaxDate(DateTime now) {
    final DateTime lastDayDateTime = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 0)
        : DateTime(now.year + 1, 1, 0);
    final DateTime currentDateTime = DateTime.now();
    if (currentDateTime.isAfter(lastDayDateTime)) {
      return lastDayDateTime;
    } else {
      return DateTime.now();
    }
  }

  // static Future<String> getVersion() async {}

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static const double _VerticalSpaceTiny = 5.0;
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;

  static const Widget verticalSpaceTiny = SizedBox(height: _VerticalSpaceTiny);
  static const Widget verticalSpaceSmall =
      SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium =
      SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpaceLarge =
      SizedBox(height: _VerticalSpaceLarge);

  static const Widget horizontalSpaceTiny = SizedBox(width: _VerticalSpaceTiny);
  static const Widget horizontalSpaceSmall =
      SizedBox(width: _VerticalSpaceSmall);
  static const Widget horizontalSpaceMedium =
      SizedBox(width: _VerticalSpaceMedium);
  static const Widget horizontalSpaceLarge =
      SizedBox(width: _VerticalSpaceLarge);

  static String randomString(int strlen) {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += ALLOWED_CHARACTERS[rnd.nextInt(ALLOWED_CHARACTERS.length)];
    }
    return result;
  }

  static String? getStatuscodeMsg(int statusCode) {
    if (statusCode >= 300 && statusCode <= 399) {
      return statusCode.toString() + " Redirects errors";
    } else if (statusCode >= 400 && statusCode <= 599) {
      return statusCode.toString() + " Server errors";
    }
  }

  static Future<Map> getCommonParameter({SharedPrefs? sharedPrefs}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map header = Map();
    try {
      header[Constant.SubModuleName] = Platform.isAndroid
          ? Constant.subModule_android
          : Constant.subModule_iOS;
      header[Constant.Version] = packageInfo.version;
      header[Constant.DeviceId] = await getDeviceID();
    } on Exception catch (e) {
      e.toString();
      return header;
    }
    return header;
  }

  // static Future<List<LogdataModel>> getLogData(
  //     SharedPrefs sharedPrefs, String screeName, String menuGlCode) async {
  //   List<LogdataModel> logDatList = List();
  //   var pageInTime = DateTime.now();
  //   DateFormat formatter = DateFormat(Constant.LOG_DATE_FORMAT);
  //   var pageInFormatted = formatter.format(pageInTime);
  //
  //   LogdataModel logDataModel = LogdataModel();
  //   logDataModel.fk_MenuGlCode = menuGlCode;
  //   logDataModel.dtPageIn = pageInFormatted;
  //   logDataModel.dtPageOut = pageInFormatted;
  //   logDataModel.fk_PersonGlCode = await sharedPrefs.getString(PREF_INTGLCODE);
  //   logDataModel.fk_LDGLCode =
  //       await sharedPrefs.getString(PREF_LOGININFO_INTLGLCODE);
  //   logDataModel.varSubModuleName = Platform.isAndroid
  //       ? Constant.subModule_android
  //       : Constant.subModule_iOS;
  //   logDataModel.varSystemName = await Utils.getDeviceID();
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   logDataModel.varVersion = packageInfo.version;
  //   logDataModel.varFormName = screeName;
  //   logDatList.add(logDataModel);
  //
  //   return logDatList;
  // }

  static launchURL(String url) async {
    // String url = "tel:" + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<String?> getDeviceID() async {
    String? deviceId = '';
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        //print('Running on Android:${androidInfo.androidId}');
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        //appType = 'ios';
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        //print('Running on IOS: ${iosInfo.identifierForVendor}');
        deviceId = iosInfo.identifierForVendor;
      }
    } on Exception {
      print('Failed to get platform version');
    }
    return deviceId;
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  static Future<String?> getMenufacturer() async {
    String? manufacturer = '';
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        //print('*****menufacturer******:${androidInfo.manufacturer}');
        manufacturer = androidInfo.manufacturer;
      }
    } on Exception {
      print('Failed to get platform version');
    }
    return manufacturer;
  }

  static Future<String> getUserName(SharedPrefs sharedPrefs) async {
    PersonMst loginResModel = PersonMst.fromJson(
        json.decode(await sharedPrefs.getString(Constant.USER_DATA)));

    print(loginResModel.varFirstName);
    print(loginResModel.varLastName);

    return loginResModel.varFirstName! + " " + loginResModel.varLastName!;
  }

  // static Future<String> encryptPasswordForRe(String password) {
  //   // return AddonsPlugin().encodeData(password, "B4V2A1C@S#S\$F", password);
  // }

  // static Future<String> descriptionPasswordForRe(String encriptionData) {
  //   // return AddonsPlugin()
  //   //     .decodeData(encriptionData, "B4V2A1C@S#S\$F", encriptionData);
  // }

  static String getSelectedYear(String dateFormat, DateTime dateTime) {
    final DateFormat displayFormater = DateFormat(dateFormat);
    final String formatted = displayFormater.format(dateTime);
    print('===getCurrentDateTime====$formatted');
    return formatted;
  }

  static Future<Map> getAuthParameterForProfile(SharedPrefs sharedPrefs) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await sharedPrefs.setString(PREF_VERSION, '${packageInfo.version}');

    Map header = Map();
    try {
      if (sharedPrefs == null) {
        header['user_id'] = '6941';
        header['password'] = 'QjZDRTk0NjhENjBDRTc2NBROtWWsyDtk04gsjzL0vUs=';
        header['version'] = '19.1.3';
        header['version_code'] = '28';
        header['imei'] = '355649083269261';
        header['country_id'] = '98';
      } else {
        LoginResModel loginResModel = LoginResModel.fromJson(
            jsonDecode(await sharedPrefs.getString(Constant.USER_DATA)));
        header['user_id'] = loginResModel.userId /*"6941"*/;
        header['password'] =
            await sharedPrefs.getString(Constant.USER_PASSWORD);
//        header['user_id'] = "6941";
        header['country_id'] = loginResModel.countryId /*"98"*/;

        /*"RDQ1ODFDMjYxNkYyRTYxQ9I1F3yvxXlw6ZTe4kpuKoA=\n"*/;
      }
      header['version'] = packageInfo.version;
      header['version_code'] = packageInfo.buildNumber;
      header['imei'] = await getDeviceID();
      /* else {
        LoginResModel loginResModel = LoginResModel.fromJson(
            jsonDecode(await sharedPrefs.getString(Constant.USER_DATA)));
        header['user_id'] = loginResModel.userId;
        header['password'] = 'RDUzQjE5QkY2QzMyMjBFRO73AWrEb1Zt/lMhbTl3T54=';
        header['version'] = '19.1.3';
        header['version_code'] = '28';
        header['imei'] = '355649083269261';
        header['country_id'] = loginResModel.countryId;
      }*/

    } on Exception catch (e) {
      e.toString();
      return header;
    }
    return header;
  }

  static Future<String> getAppVersion() async {
    try {
      return Constant.Version;
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<String> getSubModuleName() async {
    try {
      return Platform.isAndroid
          ? "BASF_HK_FARMER_FLUTTER_ANDROID"
          : "BASF_HK_FARMER_FLUTTER_IOS";
    } catch (e) {
      print(e);
      return '';
    }
  }

  // static Future<bool> updateApiToken(EcpSyncPlugin _battery,
  //     SharedPrefs sharedPrefs, BuildContext context, int value) async {
  //   bool isApiTokenUpdate = false;
  //   String isConnection = await _battery.checkInternet();
  //   if (isConnection != null && isConnection.contains('true')) {
  //     Map map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
  //     map['UserName'] = await sharedPrefs.getString(PREF_USERID);
  //     map['Password'] = await sharedPrefs.getString(PREF_VARPASSWORD);
  //     // map['FCMToken'] = "";
  //     map['FCMToken'] = await sharedPrefs.getString(PREF_NOTIFICATION_TOKEN);
  //     map['LanguageId'] = await sharedPrefs.getString(PREF_fk_LanguageGlCode);
  //     map['IsVersionCheck'] = "Y|N";
  //     print('updateToken:::$map');
  //
  //     final response = await http
  //         .post(Constant.BASE_URL + Constant.Login,
  //             body: map,
  //             headers: {
  //               'Accept': 'application/json',
  //               'Content-Type': 'application/x-www-form-urlencoded',
  //             },
  //             encoding: Encoding.getByName('UTF-8'))
  //         .timeout(Duration(minutes: 6));
  //
  //     print("Login Response---" + utf8.decode(response.bodyBytes).toString());
  //
  //     if (response.statusCode == 200) {
  //       GeneralResponseModel responseModel =
  //           GeneralResponseModel.fromJsonStatus(
  //               json.decode(utf8.decode(response.bodyBytes)));
  //       if (responseModel.status == '1') {
  //         print("token---" + responseModel.getLoginDetail().varAPIToken);
  //         await sharedPrefs.setString(
  //             PREF_APITOKEN, responseModel.getLoginDetail().varAPIToken);
  //         await setMenuProperly(responseModel.getMenuAccess(), sharedPrefs);
  //
  //         isApiTokenUpdate = true;
  //       } else if (responseModel.status == '2') {
  //         await showCheckUpdateDialogMessage(
  //             responseModel.browserFile, context, value);
  //         return isApiTokenUpdate;
  //       } else if (responseModel.status == '0') {
  //         await showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (context) {
  //             return CustomAlertLogDialog(
  //               title: LocaleUtils.getString(context, 'alert'),
  //               content: responseModel.message,
  //               textPositiveButton: LocaleUtils.getString(context, 'OK'),
  //               isShowNagativeButton: false,
  //               colorVal: Color(value),
  //               onPressedPositive: () async {
  //                 // final Route route =
  //                 //     CupertinoPageRoute(builder: (context) => Login());
  //                 // await Navigator.pushAndRemoveUntil(
  //                 //     context, route, (Route<dynamic> route) => false);
  //               },
  //             );
  //           },
  //         );
  //       }
  //       return isApiTokenUpdate;
  //     }
  //     return isApiTokenUpdate;
  //   }
  // }

  static Future<bool?> showCheckUpdateDialogMessage(
      String file, BuildContext context, int value) async {
    bool? isWhich = await showDialog(
        context: context,
        builder: (BuildContext context) => CustomLogoutAlertDialog(
              title: LocaleUtils.getString(context, 'alert'),
              title4: LocaleUtils.getString(context, 'take_lateast_version'),
              text: LocaleUtils.getString(context, 'OK'),
              text1: LocaleUtils.getString(context, 'Cancel_'),
              confirmColor: Color(value),
              cancelColor: Color(colorPrimary),
              textColor: Colors.white,
              textColor1: Colors.white,
              onPressedCancel: () {
                Navigator.pop(context, false);
              },
              onPressedConfirm: () async {
                // Navigator.pop(context, true);
                // await Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => CheckUpdateScreen(file)));
              },
            ));

    return isWhich;
  }

  // static Future<GeneralResponseModel> logoutApiCall(
  //     SharedPrefs sharedPrefs, BaseModel model) async {
  //   model.setBusy(true);
  //   GeneralResponseModel responseModel;
  //   Map map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
  //   map['PersonId'] = await sharedPrefs.getString(PREF_INTGLCODE);
  //   map['LoginDetailId'] =
  //       await sharedPrefs.getString(PREF_LOGININFO_INTLGLCODE);
  //   map['SessionTimeOut'] = 'N';
  //   map[Constant.APIToken] = await sharedPrefs.getString(PREF_APITOKEN);
  //   map['Flag'] = "U";
  //   print("map===" + map.toString());
  //
  //   final response = await http
  //       .post(Constant.BASE_URL + Constant.Insert_Update_Login_Details,
  //           body: map,
  //           headers: {
  //             'Accept': 'application/json',
  //             'Content-Type': 'application/x-www-form-urlencoded',
  //           },
  //           encoding: Encoding.getByName('UTF-8'))
  //       .timeout(Duration(minutes: 6));
  //
  //   print("Login out Response---" + utf8.decode(response.bodyBytes).toString());
  //
  //   if (response.statusCode == 200) {
  //     model.setBusy(false);
  //     GeneralResponseModel responseModel = GeneralResponseModel.fromJsonStatus(
  //         json.decode(utf8.decode(response.bodyBytes)));
  //     if (responseModel.status == '1') {
  //       return responseModel;
  //     }
  //   } else {
  //     model.setBusy(false);
  //   }
  //   return responseModel;
  // }

  static List<DrawerItem> decodeList(String data) {
    return (json.decode(data) as List<dynamic>)
        .map<DrawerItem>((item) => DrawerItem.fromJson(item))
        .toList();
  }

  static String encodeList(List<DrawerItem> data) => json.encode(
        data.map<Map<String, dynamic>>((i) => DrawerItem.toMap(i)).toList(),
      );

  static setMenuProperly(
      List<MenuMst> menuList, SharedPrefs sharedPrefs) async {
    List<DrawerItem> mainMenuList = [];
    List<DrawerItem> rightMenuList = [];

    for (int i = 0; i < menuList.length; i++) {
      print("Name--" + menuList[i].varDisplayName!);
      if (menuList[i].varTransactionCode!.startsWith('FRM_MAIN_')) {
        DrawerItem data = DrawerItem();
        if (menuList[i].varTransactionCode!.contains('FRM_MAIN_HOM')) {
          data.title = menuList[i].varDisplayName;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.icon = 'assets/home_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          mainMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_MAIN_CNT')) {
          data.title = menuList[i].varDisplayName;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.icon = 'assets/footer_call.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          mainMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_MAIN_OFR')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/mypoint_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          mainMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_MAIN_PNT')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/mypoint_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          mainMenuList.add(data);
        }
      } else if (menuList[i].varTransactionCode!.startsWith('FRM_RIGHT_')) {
        DrawerItem data = DrawerItem();

        if (menuList[i].varTransactionCode!.contains('FRM_RIGHT_REN')) {
          data.title = menuList[i].varDisplayName;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.icon = 'assets/refer_earn_drawer_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          rightMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_RIGHT_STG')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/settings_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          rightMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_RIGHT_SML')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/location_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          rightMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_RIGHT_NBR')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/nearby_drawer.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          mainMenuList.add(data);
          rightMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_RIGHT_PFL')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/profile_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          mainMenuList.add(data);
          rightMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_RIGHT_PI')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/product_icon.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          rightMenuList.add(data);
        } else if (menuList[i].varTransactionCode!.contains('FRM_RIGHT_LGT')) {
          data.title = menuList[i].varDisplayName;
          data.icon = 'assets/logout.png';
          data.chrDisplay = menuList[i].chrDisplay;
          data.menuGlCode = menuList[i].intGlCode.toString();
          data.varTransactionCode = menuList[i].varTransactionCode;
          data.isVisible = menuList[i].chrDisplay == 'Y';
          data.intDisplay_Order = menuList[i].intDisplayOrder;
          rightMenuList.add(data);
        }
      }
    }

    rightMenuList.sort((a, b) {
      return a.intDisplay_Order
          .toString()
          .compareTo(b.intDisplay_Order.toString());
    });
  }

  static String getProjectIcon() {
    if(Constant.IS_DEMO_APP == 'Y') {
      return 'assets/ecubix_icon_for_demo.png';
    }else {
      return 'assets/ecubix_logo_forall.png';
    }
  }

  static String getSplashSubProjectIcon() {
    if(Constant.IS_DEMO_APP == 'Y') {
      return 'assets/ecubix_icon_for_demo.png';
    }else {
      return 'assets/ecubix_logo_forall_old.png';
    }
  }

  static String getSplashProjectIcon() {
    return 'assets/ic_launcher.png';
  }

  static String getProjectTitle() {
    if(Constant.IS_DEMO_APP == 'Y') {
      return 'ecubix QR';
    }else {
      return 'Indofil QR';
    }

  }

  static String getProjectHeaderIcon() {
    return 'assets/inner_header_logo.png';
  }

  static String getProjectFooterIcon() {
    return 'assets/footer_logo.png';
  }

  static Future<bool> checkLocationPermission() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      return true;
    } else {
      if (await Geolocator.checkPermission() ==
          LocationPermission.deniedForever) {
        Utils.showToastMessage(
            'Location permissions are permanently denied, we cannot request permissions.');
        await Geolocator.openLocationSettings();
        return false;
      } else {
        Utils.showToastMessage(
            "Location services are disabled. Please enable.");

        if (await PermissionsService.hasPermission()) {
          PermissionsService.requestPermission();
        }

        return false;
      }
    }
  }

  static checkInternetConnection() async {
    // String? isConnection = await AddonsPlugin.checkInternet;
    // if (isConnection != null && isConnection.contains('true')) {
    //   return true;
    // } else {
    //   return false;
    // }

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<void> showAppInfoDialog(BuildContext mContext) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final StringBuffer buffer = StringBuffer();
    buffer.writeln(
        '${LocaleUtils.getString(mContext, 'server_name')} :  ${Constant.BASE_URL}');
    buffer.writeln(
        '${LocaleUtils.getString(mContext, 'application_name')} : ${packageInfo.version} - ${Constant.SERVER}');
    buffer.writeln(
        '${LocaleUtils.getString(mContext, 'device_id')} : ${await getDeviceID()}');
    // buffer.writeln('${LocaleUtils.getString(mContext, 'country_name')} : V1');

    await showDialog<Map>(
      barrierDismissible: false,
      context: mContext,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async {
              return Future.value(false);
            },
            child: CustomAppInfoDialog(
              content: buffer.toString(),
              title: Utils.getProjectTitle(),
              isShowNagativeButton: false,
              textNagativeButton: '',
              textPositiveButton: LocaleUtils.getString(mContext, 'ok'),
              onPressedNegative: () {},
              onPressedPositive: () {},
            ));
      },
    );
  }
  static checkForUpdatesFromPlayStore() async {
    // Get available update info
    final updateInfo = await InAppUpdate.checkForUpdate();
    print('updateInfo===$updateInfo');
    // Check if there is an update available
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      var result = await InAppUpdate.performImmediateUpdate();
      if (result == AppUpdateResult.userDeniedUpdate) {
        checkForUpdatesFromPlayStore();
      }
    } else if (updateInfo.updateAvailability ==
        UpdateAvailability.updateNotAvailable) {
      Utils.showToastMessage('No Update available in play store');
    }
  }
}
