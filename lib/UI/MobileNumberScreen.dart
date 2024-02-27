import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/UI/OTPScreen.dart';
import 'package:flutter_basf_hk_app/UI/OptionScreen.dart';
import 'package:flutter_basf_hk_app/Utils/CustomAppBar.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/MobileNumberBloc.dart';
import 'package:flutter_basf_hk_app/components/CustomAlertDialogLogin.dart';
import 'package:flutter_basf_hk_app/components/CustomProgressBar.dart';
import 'package:flutter_basf_hk_app/components/FadeBUAnimation.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';
import 'package:flutter_basf_hk_app/webservices/Constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../components/CustomAlertLogDialog.dart';
import 'CheckUpdateScreen.dart';
import 'WebViewScreen.dart';

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  BuildContext? mContext;
  late Size screenSize;
  MobileNumberBloc? mobileNumberBloc;
  SharedPrefs? sharedPrefs;
  Position? currentLocation;
  DateTime? currentBackPressTime;
  Map<Permission, PermissionStatus>? statuses;
  int temp = 0;
  String mobileNumber = '';
  bool isOTP = false;

  @override
  void initState() {
    super.initState();
    sharedPrefs = SharedPrefs();
    Future.delayed(Duration(seconds: 1), () async {

      if (mobileNumberBloc != null) {
        await checkUpdateApiCall();
        await callConfigure();
        try {
          await getUserLocation();
        } catch (e) {
          print(e.toString());
          var locationStatus = await getLocationPermission();
          if (locationStatus == PermissionStatus.permanentlyDenied ||
              (locationStatus == PermissionStatus.denied)) {
            setState(() {
              Constant.locationPermission = false;
            });
          } else if (locationStatus == PermissionStatus.granted) {
            try {
              var position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
              );
              print(position.toString());
              setState(() {
                currentLocation = position;
              });
            } on Exception catch (e) {
              setState(() {
                Constant.locationPermission = false;
              });
              print(currentLocation.toString());
            }
          }
        }
        await Permission.camera.request();

        mobileNumber = await sharedPrefs!.getString(PREF_Mobile);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    mContext = context;
    return ChangeNotifierProvider<MobileNumberBloc>(
        create: (BuildContext context) => MobileNumberBloc(context),
        child: Consumer(builder: (BuildContext context,
            MobileNumberBloc mobileNumberBloc, Widget? child) {
          this.mobileNumberBloc = mobileNumberBloc;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
            child: SafeArea(
              child: AbsorbPointer(
                absorbing: mobileNumberBloc.busy,
                child: WillPopScope(
                  onWillPop: onWillPop,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar:
                        CustomAppBar(Platform.isIOS ? true : false, false, () {
                      clearAllData();
                    }),
                    body: Scaffold(
                        resizeToAvoidBottomInset: false,
                        body: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Utils.hideKeyBoard(context);
                              },
                              child: Container(
                                color: Color(colorPrimary),
                                child: Container(
                                  width: screenSize.width,
                                  height: screenSize.height,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 20, right: 20),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Welcome to ecubix Channel Performance Management',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,),
                                              ),
                                            ),
                                            FadeBUAnimation(
                                                1.5,
                                                Container(
                                                  height: 50,
                                                  padding: EdgeInsets.all(5),
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 50,
                                                      bottom: 60),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Text(
                                                            '+91',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                              fontFamily: 'Roboto',
                                                              fontWeight: FontWeight.w400,),
                                                          )),
                                                      Expanded(
                                                          child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child:
                                                            mobileTextField(),
                                                      )),
                                                    ],
                                                  ),
                                                )),
                                            FadeBUAnimation(
                                              2,
                                              Align(
                                                alignment: Alignment.center,
                                                child: InkWell(
                                                  onTap: () async {
                                                    Utils.hideKeyBoard(context);

                                                    await navigateToScreen();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    decoration: BoxDecoration(
                                                        color: mobileNumberBloc
                                                                    .mobileController
                                                                    .text
                                                                    .length ==
                                                                10
                                                            ? Color(
                                                                colorPrimary)
                                                            : Color(
                                                                colorPrimaryDark),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    padding: EdgeInsets.only(
                                                        left: 30,
                                                        right: 30,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Text(
                                                      mobileNumberBloc
                                                                  .isOTPConfig !=
                                                              null
                                                          ? isOTP
                                                              ? LocaleUtils
                                                                  .getString(
                                                                      mContext,
                                                                      'send_otp')
                                                              : LocaleUtils
                                                                  .getString(
                                                                      mContext,
                                                                      'proceed')
                                                          : LocaleUtils
                                                              .getString(
                                                                  mContext,
                                                                  'proceed'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Roboto',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FadeBUAnimation(
                                        2.5,
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Image.asset(
                                            Utils.getProjectFooterIcon(),
                                            width: login_logo_120,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Visibility(
                                visible: mobileNumberBloc.busy,
                                child: CustomProgressBar(),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget mobileTextField() {
    return TextFormField(
      cursorColor: Colors.black,
      maxLines: 1,
      controller: mobileNumberBloc!.mobileController,
      keyboardType: TextInputType.number,
      // enabled: checkNet,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: mobileNumberBloc!.mobileController.text.isEmpty
              ? LocaleUtils.getString(mContext, 'enter_mobile_number')
              : ''),
      style: TextStyle(fontSize: 16,fontFamily: 'Roboto',fontWeight: FontWeight.w500),
      onChanged: (a) {
        setState(() {
          if (mobileNumberBloc!.isOTPConfig != null &&
              mobileNumberBloc!.isOTPConfig!) {
            if (mobileNumber == a) {
              isOTP = false;
            } else {
              isOTP = true;
            }
          }
        });
      },
    );
  }

  Future<bool> onWillPop() {
    var now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showToastMessage(LocaleUtils.getString(mContext, 'back_msg'));
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<Position> locateUser() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return Future.error(LocaleUtils.getString(mContext, 'lct_msg1'));
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      setState(() {
        temp = 1;
      });
      if (temp == 1) {
        setState(() {
          Constant.locationPermission = false;
        });
      }
      if (permission == LocationPermission.deniedForever) {
        // Utils.showToastMessage(LocaleUtils.getString(mContext, 'lct_msg1'));
        return Future.error(LocaleUtils.getString(mContext, 'lct_msg1'));
      } else if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        setState(() {
          Constant.locationPermission = true;
        });
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Utils.showToastMessage(LocaleUtils.getString(mContext, 'lct_msg'));
      return Future.error(LocaleUtils.getString(mContext, 'lct_msg'));
    }

    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getUserLocation() async {
    currentLocation = await locateUser();
    print('currentLocation--- $currentLocation');
  }

  Future<void> checkUpdateApiCall() async {
    if (await Utils.checkInternetConnection()) {
      var map = await Utils.getCommonParameter(sharedPrefs: sharedPrefs);
      map['FCMToken'] = '';
      map['PersonId'] = '';
      print('map:::$map');

      mobileNumberBloc!.setBusy(true);
      try {
        var URL = Constant.BASE_URL + Constant.CheckVersion;
        print('URL-' + URL);
        var headers = <String, String>{
          'Content-Type': 'application/json',
          'X-ApiKey': 'i3BalYxQL'
        };
        final response = await http
            .post(
              Uri.parse(URL),
              body: jsonEncode(map),
              headers: headers,
              // encoding: Encoding.getByName('UTF-8')
            )
            .timeout(Duration(minutes: 6));

        print('======response====== ' + utf8.decode(response.bodyBytes));
        Map<String, dynamic> statusMap =
            json.decode(utf8.decode(response.bodyBytes));
        print('status::::${statusMap['Status']}');
        if (response.statusCode == 200 && statusMap['Status'] == '1') {
          try {
            // Utils.showToastMessage('Your device software is up to date');
          } finally {
            mobileNumberBloc!.setBusy(false);
          }
        } else {
          if (response.statusCode == 200) {
            print('status-' + response.statusCode.toString());
            mobileNumberBloc!.setBusy(false);
            print('status-' + statusMap['Status']);
            if (statusMap['Status'] == '1') {
              Utils.showToastMessage(statusMap['Message']);
            } else {
              print('file==${statusMap['File']}');
              print('BrowserFile==${statusMap['BrowserFile']}');
              showCheckUpdateDialogMessage(statusMap['BrowserFile']);
            }
          }
        }
      } on Exception catch (e) {
        mobileNumberBloc!.setBusy(false);
        Utils.showToastMessage(
            LocaleUtils.getString(context, 'servernotrespond'));
      }
    } else {
      Utils.showToastMessage(
          LocaleUtils.getString(context, 'no_internet_connection'));
    }
  }

  void showCheckUpdateDialogMessage(String? file) async {
    await showDialog(
        context: mContext!,
        barrierDismissible: false,
        builder: (BuildContext context) => CustomAlertDialogLogin(
              title: LocaleUtils.getString(context, 'alert'),
              content: LocaleUtils.getString(context, 'take_lateast_version'),
              isShowNagativeButton: false,
              textPositiveButton: LocaleUtils.getString(context, 'ok'),
              onPressedPositive: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CheckUpdateScreen(file)));
              },
            ));
  }

  Future<bool> checkPermissionData() async {
    if (!Constant.locationPermission) {
      if (await Permission.camera.isGranted) {
        return true;
      }
    } else {
      if (await Permission.camera.isGranted &&
          await Permission.location.isGranted) {
        return true;
      }
    }
    /*if (await Permission.location.isGranted &&
        await Permission.camera.isGranted) {
      return true;
    }*/
    return false;
  }

  void clearAllData() {
    showDialog<Map>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: CustomAlertLogDialog(
              content: LocaleUtils.getString(mContext, 'clear_data'),
              title: Utils.getProjectTitle(),
              isShowNagativeButton: true,
              textNagativeButton: LocaleUtils.getString(mContext, 'yes'),
              textPositiveButton: LocaleUtils.getString(mContext, 'no'),
              onPressedNegative: () async {
                await sharedPrefs!.clearPrefs();
                mobileNumberBloc!.mobileController.clear();
                setState(() {});
              },
              onPressedPositive: () {},
            ));
      },
    );
  }

// Future<void> checkNetThere() async {
//   checkNet = await Utils.checkInternetConnection(ecpSyncPlugin);
// }

  Future<PermissionStatus> getLocationPermission() async {
    var status = await Permission.location.status;
    print('status--$status');
    if (status == PermissionStatus.denied) {
      status = await Permission.location.request();
    }
    return status;
  }

  Future<void> navigateToScreen() async {
    if (mobileNumberBloc!.mobileController.text.isNotEmpty) {
      if (mobileNumberBloc!.mobileController.text.length == 10) {
        if (await Utils.checkInternetConnection()) {
          mobileNumberBloc!.setBusy(true);
          try {
            if (Constant.locationPermission) {
              await getUserLocation();
            }
          } catch (e) {
            print(e.toString());
            mobileNumberBloc!.setBusy(false);
          }
          if (mobileNumberBloc!.isOTPConfig!) {
            if (isOTP) {
              await mobileNumberBloc!
                  .OTPGenerate(mobileNumberBloc!.mobileController.text.trim());

              if (mobileNumberBloc!.generalResponseModel!.status == '1') {

                if (isOTP) {
                  Utils.showToastMessage(
                      mobileNumberBloc!.generalResponseModel!.message!);
                  bool isOkay = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => OTPScreen(
                              mobileNumberBloc!.mobileController.text
                                  .toString()
                                  .trim(),
                              mobileNumberBloc!.oTPConfigTimer)));
                  if (isOkay) {
                    mobileNumberBloc!.getMobileNumber();
                    mobileNumber = await sharedPrefs!.getString(PREF_Mobile);
                    setState(() {
                      isOTP = false;
                    });
                  }
                } else {
                  await Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        OptionScreen(
                            'Scan QR Code',
                            mobileNumberBloc!.mobileController.text
                                .toString()
                                .trim()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ));
                }
              } else {
                Utils.showToastMessage(
                    mobileNumberBloc!.generalResponseModel!.message!);
              }
            } else {
              await registerApiCall();
            }
          } else {
            await registerApiCall();
          }
        } else {
          var data = await sharedPrefs!.getString(PREF_Mobile);

          if (data.isEmpty) {
            Utils.showToastMessage(
                LocaleUtils.getString(mContext, 'no_internet_connection'));
          } else {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OptionScreen(
                    'Scan QR Code',
                    mobileNumberBloc!.mobileController.text
                        .toString()
                        .trim())));

            mobileNumberBloc!.mobileController.text = data;

            setState(() {});
          }
        }
        /* } else {
                                                        if (await geo.Geolocator
                                                                .checkPermission() ==
                                                            LocationPermission
                                                                .deniedForever) {
                                                          Utils.showToastMessage(
                                                              LocaleUtils
                                                                  .getString(
                                                                      mContext,
                                                                      'lct_msg'));
                                                          await Geolocator
                                                              .openLocationSettings();
                                                        } else {
                                                          Utils.showToastMessage(
                                                              LocaleUtils
                                                                  .getString(
                                                                      mContext,
                                                                      'lct_msg1'));
                                                        }
                                                      }*/
      }
    }
  }

  Future<void> callConfigure() async {
    if (await Utils.checkInternetConnection()) {
      await mobileNumberBloc!.checkConfigure();
      if (mobileNumberBloc!.generalResponseModel != null &&
          mobileNumberBloc!.generalResponseModel!.status == '1') {
        mobileNumberBloc!.setConfigure(getConfiguration());
        mobileNumberBloc!.setConfigureTimer(getConfigurationTimer());
      }
    } else {
      Utils.showToastMessage(
          LocaleUtils.getString(context, 'no_internet_connection'));
    }
  }

  Future<void> registerApiCall() async {
    await mobileNumberBloc!.registerCall(
        mobileNumberBloc!.mobileController.text.trim(),
        '${currentLocation != null ? currentLocation!.latitude : ''}',
        '${currentLocation != null ? currentLocation!.longitude : ''}');
    if (mobileNumberBloc!.generalResponseModel!.status == '1') {
      await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => OptionScreen(
            'Scan QR Code',
            mobileNumberBloc!.mobileController.text.toString().trim()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));
    } else {
      Utils.showToastMessage(mobileNumberBloc!.generalResponseModel!.message!);
    }
  }

  bool getConfiguration() {
    var isConfig = false;

    for (var i = 0; i < mobileNumberBloc!.mobileOREmailVerify.length; i++) {
      if (mobileNumberBloc!.mobileOREmailVerify[i].isEnable == 'Y') {
        isConfig = true;
        break;
      } else {
        isConfig = false;
        break;
      }
    }

    return isConfig;
  }

  String getConfigurationTimer() {
    String? isConfigTimer = '0';

    for (var i = 0; i < mobileNumberBloc!.mobileOREmailVerify.length; i++) {
      if (mobileNumberBloc!.mobileOREmailVerify[i].isEnable == 'Y' &&
          mobileNumberBloc!.mobileOREmailVerify[i].intOTPTimer!.isNotEmpty) {
        isConfigTimer = mobileNumberBloc!.mobileOREmailVerify[i].intOTPTimer;
      }
    }

    return isConfigTimer!;
  }
}
