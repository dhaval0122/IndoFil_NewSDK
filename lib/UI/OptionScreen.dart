import 'dart:async';

import 'package:ecp_sync_plugin/ecp_sync_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/UI/ScanScreen.dart';
import 'package:flutter_basf_hk_app/UI/WebViewScreen.dart';
import 'package:flutter_basf_hk_app/Utils/CustomAppBar.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/OptionScreenBloc.dart';
import 'package:flutter_basf_hk_app/components/CustomProgressBar.dart';
import 'package:flutter_basf_hk_app/components/FadeBUAnimation.dart';
import 'package:flutter_basf_hk_app/components/LengthLimitingTextFieldFormatterFixed.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../webservices/Constant.dart';
import 'ProductDetailScreen.dart';

class OptionScreen extends StatefulWidget {
  final String name;
  final String mNo;

  OptionScreen(this.name, this.mNo);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  late OptionScreenBloc optionScreenBloc;
  BuildContext? mContext;
  late SharedPrefs sharedPrefs;
  Position? currentLocation;
  Map<Permission, PermissionStatus>? statuses;
  late EcpSyncPlugin _battery;
  late StreamSubscription<Map> _batteryStateSubscription;
  String? isValid = '';

  @override
  void initState() {
    super.initState();
    _battery = EcpSyncPlugin();
    sharedPrefs = SharedPrefs();

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((Map state) async {
      try {
        print('=======state=======${state.toString()}');
        if (state['type'] == '777') {
          var detailsData = state['Details'];
          print('====detailsData.toString()====${detailsData.toString()}');
          var code = detailsData.toString().split('::');
          print('====F CODE==length===${code.length}');
          if (code.isNotEmpty) {
            if (code[0].toString() == 'PS') {
              print('====PS===${code[1].toString()}');
              optionScreenBloc.progressEvent(true);
            } else if (code[0].toString() == 'PD') {
              print('====PD===${code[1].toString()}');
              optionScreenBloc.progressEvent(false);
            } else if (code[0].toString() == 'PResult') {
              optionScreenBloc.progressEvent(false);
              print('====PResult===${code[1].toString()}');

              if (code[1].toString().toUpperCase() == 'PASS') {
                isValid = 'Y';
              } else if (code[1].toString().toUpperCase() == 'FAIL') {
                isValid = 'N';
              } else {
                isValid = '';
                Utils.showToastMessage(code[1].toString());
              }
            } else if (code[0].toString() == 'PData') {
              optionScreenBloc.progressEvent(false);
              // Utils.showToastMessage(code[1].toString());
              print('====PData===${code[1].toString()}');

              if (code[1].toString().isNotEmpty) {
                if (await Utils.checkInternetConnection()) {
                  print("test--" + Constant.locationPermission.toString());
                  try {
                    if (Constant.locationPermission) {
                      optionScreenBloc.setBusy(true);
                      await getUserLocation();
                    }
                  } catch (e) {
                    optionScreenBloc.setBusy(false);
                    print(e.toString());
                  }

                  // apicall
                  print("test--" + currentLocation.toString());

                  /*await optionScreenBloc.getUrlFromStricker(
                      'I1ELUFW9',
                      currentLocation);*/

                  getData(code[1].toString());

                  var stickerData = getStickerFromURL(code[1].toString());

                  print('====Data===$stickerData');

                  await optionScreenBloc.getUrlFromStricker(
                      stickerData, currentLocation);

                  if (optionScreenBloc.generalResponseModel != null &&
                      optionScreenBloc.generalResponseModel!.status == '1' &&
                      optionScreenBloc.generalResponseModel!
                              .getUrlFromSticker() !=
                          null &&
                      optionScreenBloc.generalResponseModel!
                          .getUrlFromSticker()!
                          .isNotEmpty) {
                    await optionScreenBloc.setUrl(optionScreenBloc
                        .generalResponseModel!
                        .getUrlFromSticker());
                    getData(optionScreenBloc.generalResponseModel!
                        .getUrlFromSticker()!);
                    if (optionScreenBloc.uniqueData!.isNotEmpty) {

                      // var isSDKScan =
                      // await sharedPrefs
                      //     .getString(
                      //     PREF_IS_SDK_SCAN_ENABLE);
                      // if (isSDKScan == 'N') {
                      //   setState(
                      //           () {
                      //         optionScreenBloc
                      //             .serialController
                      //             .clear();
                      //       });
                      //
                      //   await Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => ProductDetailScreen(
                      //           optionScreenBloc.uniqueData,
                      //           optionScreenBloc.batchNo,
                      //           optionScreenBloc.mfgdate,
                      //           optionScreenBloc.exdate,
                      //           widget.mNo,
                      //           optionScreenBloc.url,
                      //           isValid)));
                      // } else {
                        navigateToAuthenticScreen();
                      // }
                    }
                  } else {
                    // setState(
                    //         () {
                    //       optionScreenBloc
                    //           .serialController
                    //           .clear();
                    //     });
                    Utils.showToastMessage(
                        LocaleUtils.getString(mContext, 'invalid_qr_code'));
                  }
                } else {
                  Utils.showToastMessage(LocaleUtils.getString(
                      mContext, 'no_internet_connection'));
                }
              } else {
                Utils.showToastMessage('Please Scan QR Code Again');
              }
            } else {
              optionScreenBloc.progressEvent(false);
              print('====Else===${code[1].toString()}');
            }
          }
        }else if(state['type'] == '888'){
          Utils.showToastMessage("Retry");
          optionScreenBloc.progressEvent(false);
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void navigateToAuthenticScreen() async{
      // only for dev
      // print("print===${widget.scanData!.contains("https://www.ivcs.ai:8090")}");
      // if(widget.scanData!.contains('https://www.ivcs.ai:8090')){
      //   widget.scanData=widget.scanData!.replaceAll('https://www.ivcs.ai:8090','http://172.16.10.70/eCubix_Product_Info');
      //   setState(() {
      //
      //   });
      // }
      // print("widget.scanData===${widget.scanData}");

      var url;
      if(isValid!.isNotEmpty) {
        url =
        '${optionScreenBloc.url}&MOB=${widget.mNo}&LAT=${currentLocation != null
            ? currentLocation!.latitude
            : ''}&LONG=${currentLocation != null
            ? currentLocation!.longitude
            : ''}&DVC=${await Utils.getDeviceID()}&FRM=D&LNG=1&IsValid=$isValid';
      } else {
        url =
        '${optionScreenBloc.url}&MOB=${widget.mNo}&LAT=${currentLocation != null
            ? currentLocation!.latitude
            : ''}&LONG=${currentLocation != null
            ? currentLocation!.longitude
            : ''}&DVC=${await Utils.getDeviceID()}&FRM=D&LNG=1';
      }
      var isBack = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => WebViewScreen(url)));

      // if (isBack != null && isBack) {
      //   Navigator.pop(context, true);
      // }
      // productDetailBloc.setBusy(false);

  }

  @override
  void dispose() {
    super.dispose();
    // _batteryStateSubscription.cancel();
    // _battery = null!;
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return ChangeNotifierProvider<OptionScreenBloc>(
      create: (BuildContext context) => OptionScreenBloc(context),
      child: Consumer<OptionScreenBloc>(
        builder: (context, provider, child) {
          optionScreenBloc = provider;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
            child: SafeArea(
                child: AbsorbPointer(
                    absorbing: provider.busy,
                    child: WillPopScope(
                        onWillPop: () async {
                          Utils.hideKeyBoard(context);
                          Navigator.pop(context, true);
                          return true;
                        },
                        child: Scaffold(
                            resizeToAvoidBottomInset: false,
                            backgroundColor: Colors.white,
                            appBar: CustomAppBar(false, true, () {
                              Navigator.pop(context, true);
                            }),
                            body: Scaffold(
                              resizeToAvoidBottomInset: false,
                              body: Stack(
                                children: [
                                  Container(
                                    color: Color(colorPrimary),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(20))),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      FadeBUAnimation(
                                                          1,
                                                          Container(
                                                            height: 50,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20,
                                                                    top: 50,
                                                                    bottom: 25),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                    child:
                                                                        Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      searialTextField(),
                                                                )),
                                                              ],
                                                            ),
                                                          )),
                                                      FadeBUAnimation(
                                                        1.5,
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              Utils
                                                                  .hideKeyBoard(
                                                                      context);

                                                              if (await checkValidation()) {
                                                                if (await Utils
                                                                    .checkInternetConnection()) {
                                                                  print("test--" +
                                                                      Constant
                                                                          .locationPermission
                                                                          .toString());
                                                                  try {
                                                                    if (Constant
                                                                        .locationPermission) {
                                                                      optionScreenBloc
                                                                          .setBusy(
                                                                              true);
                                                                      await getUserLocation();
                                                                    }
                                                                  } catch (e) {
                                                                    optionScreenBloc
                                                                        .setBusy(
                                                                            false);
                                                                    print(e
                                                                        .toString());
                                                                  }

                                                                  // apicall
                                                                  print("test--" +
                                                                      currentLocation
                                                                          .toString());

                                                                  await optionScreenBloc.getUrlFromStricker(
                                                                      optionScreenBloc
                                                                          .serialController
                                                                          .text
                                                                          .trim(),
                                                                      currentLocation);

                                                                  if (optionScreenBloc.generalResponseModel != null &&
                                                                      optionScreenBloc
                                                                              .generalResponseModel!
                                                                              .status ==
                                                                          '1' &&
                                                                      optionScreenBloc
                                                                              .generalResponseModel!
                                                                              .getUrlFromSticker() !=
                                                                          null &&
                                                                      optionScreenBloc
                                                                          .generalResponseModel!
                                                                          .getUrlFromSticker()!
                                                                          .isNotEmpty) {
                                                                    await optionScreenBloc.setUrl(optionScreenBloc
                                                                        .generalResponseModel!
                                                                        .getUrlFromSticker());
                                                                    getData(optionScreenBloc
                                                                        .generalResponseModel!
                                                                        .getUrlFromSticker()!);
                                                                    if (optionScreenBloc
                                                                        .uniqueData!
                                                                        .isNotEmpty) {
                                                                      setState(
                                                                          () {
                                                                        optionScreenBloc
                                                                            .serialController
                                                                            .clear();
                                                                      });
                                                                      await Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => ProductDetailScreen(
                                                                              optionScreenBloc.uniqueData,
                                                                              optionScreenBloc.batchNo,
                                                                              optionScreenBloc.mfgdate,
                                                                              optionScreenBloc.exdate,
                                                                              widget.mNo,
                                                                              optionScreenBloc.url,
                                                                              '')));
                                                                    }
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      optionScreenBloc
                                                                          .serialController
                                                                          .clear();
                                                                    });
                                                                    Utils.showToastMessage(LocaleUtils.getString(
                                                                        mContext,
                                                                        'invalid_qr_code'));
                                                                  }
                                                                } else {
                                                                  Utils.showToastMessage(
                                                                      LocaleUtils.getString(
                                                                          mContext,
                                                                          'no_internet_connection'));
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 10),
                                                              decoration: BoxDecoration(
                                                                  // color: provider
                                                                  //             .serialController
                                                                  //             .text
                                                                  //             .length ==
                                                                  //         10
                                                                  //     ? Color(colorPrimary)
                                                                  //     : Color(
                                                                  //         colorPrimaryDark),
                                                                  color: Color(colorPrimary),
                                                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 30,
                                                                      right: 30,
                                                                      top: 10,
                                                                      bottom:
                                                                          10),
                                                              child: Text(
                                                                LocaleUtils
                                                                    .getString(
                                                                        mContext,
                                                                        'Continue'),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                FadeBUAnimation(
                                                    2,
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 30, bottom: 30),
                                                      child: Text(
                                                        LocaleUtils.getString(
                                                            mContext, 'or'),
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )),
                                                FadeBUAnimation(
                                                    2.5,
                                                    InkWell(
                                                      onTap: () async {
                                                        // await Navigator.of(
                                                        //     context)
                                                        //     .push(MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         WebViewScreen('http://c3.ivcs.ai/21/AAPPPAKD0UOOC9RX/10/QRTEST?11=231018&17=300101&MOB=9033486861&LAT=23.051017&LONG=72.4898316&DVC=0f562546c8c7a946&FRM=D&LNG=1&IsValid=Y')));

                                                        var isSDKScan =
                                                            await sharedPrefs
                                                                .getString(
                                                                    PREF_IS_SDK_SCAN_ENABLE);
                                                        if (isSDKScan == 'Y') {
                                                          isValid = '';
                                                          await _battery
                                                              .scanQRCodeViaSDK();
                                                        } else {
                                                          if (widget
                                                              .mNo.isNotEmpty) {
                                                            if (widget.mNo
                                                                    .length ==
                                                                10) {
                                                              if (await Geolocator
                                                                  .isLocationServiceEnabled()) {
                                                                if (await Utils
                                                                    .checkInternetConnection()) {
                                                                  if (await checkPermissionData()) {
                                                                    try {
                                                                      // await getUserLocation();
                                                                    } catch (e) {
                                                                      print(e
                                                                          .toString());
                                                                    }

                                                                    await Navigator.of(context).push(MaterialPageRoute(
                                                                        builder: (context) => ScanScreen(
                                                                            widget.name,
                                                                            widget.mNo)));
                                                                  } else {
                                                                    var status =
                                                                        await getCameraPermission();
                                                                    if (status ==
                                                                        PermissionStatus
                                                                            .permanentlyDenied) {
                                                                      await openAppSettings();
                                                                    } else {
                                                                      var status =
                                                                          await getCameraPermission();
                                                                      if (status ==
                                                                          PermissionStatus
                                                                              .permanentlyDenied) {
                                                                        await openAppSettings();
                                                                      }
                                                                    }
                                                                  }
                                                                } else {
                                                                  Utils.showToastMessage(
                                                                      LocaleUtils.getString(
                                                                          mContext,
                                                                          'no_internet_connection'));
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  colorPrimary),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      colorPrimary))),
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .camera_alt,
                                                                color: Colors
                                                                    .white,
                                                                size: 40,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                child: Text(
                                                                  LocaleUtils.getString(
                                                                      mContext,
                                                                      'qr_code_scan'),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Image.asset(
                                              Utils.getProjectFooterIcon(),
                                              width: login_logo_120,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Visibility(
                                      visible: provider.busy,
                                      child: CustomProgressBar(),
                                    ),
                                  ),
                                ],
                              ),
                            ))))),
          );
        },
      ),
    );
  }

  Widget searialTextField() {
    return TextField(
      cursorColor: Colors.black,
      maxLines: 1,
      controller: optionScreenBloc.serialController,
      keyboardType: TextInputType.text,
      maxLength: 10,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      // enabled: checkNet,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
        LengthLimitingTextFieldFormatterFixed(10)
      ],
      decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: optionScreenBloc.serialController.text.isEmpty
              ? LocaleUtils.getString(mContext, 'enter_qr_number')
              : ''),
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
      // textAlign: TextAlign.center,
      onChanged: (a) {
        setState(() {});
      },
    );
  }

  Future<bool> checkValidation() async {
    if (optionScreenBloc.serialController.text.isEmpty) {
      Utils.showToastMessage('Please Enter QR Code');
      return false;
    }
    return true;
  }

  Future<bool> checkPermissionData() async {
    if (!Constant.locationPermission) {
      if (await Permission.camera.isGranted) {
        return true;
      }
    } else {
      if (await Permission.camera
              .isGranted /*&&
          await Permission.location.isGranted*/
          ) {
        return true;
      }
    }
    /*if (await Permission.location.isGranted &&
        await Permission.camera.isGranted) {
      return true;
    }*/
    return false;
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {});
    print('currentLocation--- $currentLocation');
  }

  String getStickerFromURL(String varString) {
    var varUniqSTR = '';
    if (varString.contains('21/')) {
      varUniqSTR =
          varString.substring(varString.indexOf('21/'), varString.length);
      if (varUniqSTR.contains('?')) {
        var stickerNumber = varUniqSTR.split('?');
        // varUniqSTR =
        //     varString.substring(stickerNumber[0].indexOf('21/'), stickerNumber[0].length);
        print('========varUniqSTR=====$varUniqSTR');
        if (stickerNumber[0].contains('21/')) {
          var stickerNumber1 = stickerNumber[0].split('/');
          varUniqSTR = stickerNumber1[1];
          print('========0=====${stickerNumber1[0]}');
          print('========1=====${stickerNumber1[1]}');
        }
      }
    } else {
      varUniqSTR = '';
    }
    return varUniqSTR;
  }

  void getData(String varString) {
    var varUniqSTR = '';
    if (varString.contains('21/')) {
      varUniqSTR =
          varString.substring(varString.indexOf('21/'), varString.length);
      if (varUniqSTR.contains('?')) {
        var stickerNumber = varUniqSTR.split('?');
        // varUniqSTR =
        //     varString.substring(stickerNumber[0].indexOf('21/'), stickerNumber[0].length);
        print('========varUniqSTR=====$varUniqSTR');
        if (stickerNumber[0].contains('21/')) {
          var stickerNumber1 = stickerNumber[0].split('/');
          varUniqSTR = stickerNumber1[1];
          print('========0=====${stickerNumber1[0]}');
          print('========1=====${stickerNumber1[1]}');
        }
      }
    } else {
      varUniqSTR = '';
    }
    var varBATCHSTR = '';
    if (varString.contains('10/')) {
      varBATCHSTR =
          varString.substring(varString.indexOf('10/'), varString.length);
    } else {
      varBATCHSTR = '';
    }

    var varMFGSTR = '';
    // for FOC
    if (varString.contains('13=')) {
      varMFGSTR =
          varString.substring(varString.indexOf('13='), varString.length);
      print('varMFGSTR= jay=$varMFGSTR');
    }

    if (varString.contains('11=')) {
      varMFGSTR =
          varString.substring(varString.indexOf('11='), varString.length);
      print('varMFGSTR==$varMFGSTR');
    }

    var varEXPSTR = '';
    if (varString.contains('17=')) {
      varEXPSTR =
          varString.substring(varString.indexOf('17='), varString.length);
    } else {
      varEXPSTR = '';
    }
    if (varUniqSTR.isNotEmpty) {
      var data = varUniqSTR.substring(
        3,
        !varUniqSTR.contains('/10')
            ? varUniqSTR.length
            : varUniqSTR.indexOf('/10'),
      );
      optionScreenBloc.setUniqueData(data);
    }

    if (varBATCHSTR.isNotEmpty) {
      var data1 = '';
      if (varString.contains('13=')) {
        data1 = varBATCHSTR.substring(
          3,
          !varBATCHSTR.contains('?13=')
              ? varBATCHSTR.length
              : varBATCHSTR.indexOf('?13='),
        );
      } else {
        data1 = varBATCHSTR.substring(
          3,
          !varBATCHSTR.contains('?11=')
              ? varBATCHSTR.length
              : varBATCHSTR.indexOf('?11='),
        );
      }

      // var data1 = varBATCHSTR.substring(
      //   3,
      //   !varBATCHSTR.contains('?11=')
      //       ? varBATCHSTR.length
      //       : varBATCHSTR.indexOf('?11='),
      // );
      optionScreenBloc.setBatchData(data1);
    }

    if (varMFGSTR.isNotEmpty) {
      var data2 = varMFGSTR.substring(
        3,
        !varMFGSTR.contains('&17=')
            ? varMFGSTR.length
            : varMFGSTR.indexOf('&17='),
      );
      optionScreenBloc.setMfgData(data2);
    }

    if (varEXPSTR.isNotEmpty) {
      var data3 = varEXPSTR.substring(
        3,
        varEXPSTR.length,
      );
      optionScreenBloc.setExData(data3);
    }
  }

  Future<PermissionStatus> getCameraPermission() async {
    var status = await Permission.camera.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.camera.request();
    }
    return status;
  }

  Future<PermissionStatus> getLocationPermission() async {
    var status = await Permission.location.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.location.request();
    }
    return status;
  }
}

