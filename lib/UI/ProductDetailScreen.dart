import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/Utils/CustomAppBar.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/ProductDetailBloc.dart';
import 'package:flutter_basf_hk_app/components/CustomProgressBar.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../webservices/Constant.dart';
import 'WebViewScreen.dart';

class ProductDetailScreen extends StatefulWidget {
  String? uniqueData = "",
      batchNo = "",
      mfgdate = "",
      exdate = "",
      mNo = "",
      isValid = "",
      scanData = "";

  ProductDetailScreen(this.uniqueData, this.batchNo, this.mfgdate, this.exdate,
      this.mNo, this.scanData,this.isValid);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  BuildContext? mContext;
  Size? screenSize;
  late ProductDetailBloc productDetailBloc;
  SharedPrefs? sharedPrefs;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  Position? currentLocation;
  DateTime? currentBackPressTime;
  bool isFocUser = false;
  Map<Permission, PermissionStatus>? statuses;

  @override
  void initState() {
    super.initState();
    sharedPrefs = SharedPrefs();

    Future.delayed(const Duration(microseconds: 12), () {
      setState(() {
        // getUserLocation();
        if (widget.mfgdate!.isNotEmpty && widget.mfgdate!.length == 6) {
          // 210322,221027
          print("widget.mfgdate=${widget.mfgdate}");
          var year = 2000 + int.parse(widget.mfgdate!.substring(0, 2));
          var month = int.parse(widget.mfgdate!.substring(2, 4));
          var day =
              int.parse(widget.mfgdate!.substring(4, widget.mfgdate!.length));

          var date = '$year-$month-$day';
          print("date=$date");
          var tempDate = DateFormat('yyyy-MM-dd').parse(date);
          var outputFormat = DateFormat('dd-MM-yyyy');
          var outputDate = outputFormat.format(tempDate);
          print(outputDate);
          setState(() {
            widget.mfgdate = outputDate;
          });
        }
        if (widget.exdate!.isNotEmpty && widget.exdate!.length == 6) {
          // 210322
          var year = 2000 + int.parse(widget.exdate!.substring(0, 2));
          var month = int.parse(widget.exdate!.substring(2, 4));
          var day =
              int.parse(widget.exdate!.substring(4, widget.exdate!.length));

          var date = '$year-$month-$day';
          var tempDate = DateFormat('yyyy-MM-dd').parse(date);
          var outputFormat = DateFormat('dd-MM-yyyy');
          // var outputFormat = DateFormat('dd/MM/yyyy');
          var outputDate = outputFormat.format(tempDate);
          print(outputDate);

          setState(() {
            widget.exdate = outputDate;
          });
        }
      });
      checkFOCUser(widget.scanData);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    mContext = context;
    return ChangeNotifierProvider<ProductDetailBloc>(
        create: (BuildContext context) => ProductDetailBloc(context),
        child: Consumer(builder: (BuildContext context,
            ProductDetailBloc webViewScreenBloc, Widget? child) {
          productDetailBloc = webViewScreenBloc;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
            child: SafeArea(
              child: AbsorbPointer(
                absorbing: productDetailBloc.busy,
                child: WillPopScope(
                  onWillPop: () async {
                    Navigator.pop(context, true);
                    return Future.value(true);
                  },
                  child: AbsorbPointer(
                    absorbing: webViewScreenBloc.busy,
                    child: Scaffold(
                      appBar: CustomAppBar(false, true, () {
                        Navigator.pop(context, true);
                      }),
                      body: Scaffold(
                          body: Stack(
                        children: [
                          Container(
                            color: Color(colorPrimary),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 30, left: 10, right: 10),
                                // margin: EdgeInsets.only(top: 25),

                                child: Column(
                                  children: [
                                    Flexible(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        elevation: 6,
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 15,
                                            bottom: 15),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(colorPrimary),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            20.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            20.0),
                                                  )),
                                              height: 10,
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 5,
                                                          bottom: 5,
                                                          right: 5),
                                                  child: textWidget(
                                                      'Unique Identifier:',
                                                      Color(textTwoColor),
                                                      true),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: textWidget(
                                                            widget.uniqueData!,
                                                            Color(textColor),
                                                            false)))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 5,
                                                          bottom: 5,
                                                          right: 5),
                                                  child: textWidget(
                                                      'Batch Number:',
                                                      Color(textTwoColor),
                                                      true),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: textWidget(
                                                            widget.batchNo!,
                                                            Color(textColor),
                                                            false)))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 5,
                                                          bottom: 5,
                                                          right: 5),
                                                  child: textWidget(
                                                      isFocUser
                                                          ? 'Date of Packaging:'
                                                          : 'Mfg. Date:',
                                                      Color(textTwoColor),
                                                      true),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: textWidget(
                                                            widget.mfgdate!,
                                                            Color(textColor),
                                                            false)))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 5,
                                                          bottom: 5,
                                                          right: 5),
                                                  child: textWidget(
                                                      'Exp. Date:',
                                                      Color(textTwoColor),
                                                      true),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: textWidget(
                                                            widget.exdate!,
                                                            Color(textColor),
                                                            false)))
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(colorPrimary),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        const Radius.circular(
                                                            20.0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            20.0),
                                                  )),
                                              height: 10,
                                              margin: EdgeInsets.only(top: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (await Utils
                                            .checkInternetConnection()) {
                                          try {
                                            /*if (await Geolocator
                                                .isLocationServiceEnabled()) {*/
                                            if (await checkPermissionData()) {
                                              try {
                                                productDetailBloc.setBusy(true);
                                                await getUserLocation();
                                              } catch (e) {
                                                productDetailBloc
                                                    .setBusy(false);
                                                print(e.toString());
                                                // await navigatorScreen();
                                                setState(() {
                                                  Constant.locationPermission =
                                                      false;
                                                });
                                              }

                                              await navigatorScreen();
                                            } else {
                                              productDetailBloc.setBusy(false);
                                              var locationStatus =
                                                  await getLocationPermission();
                                              if (locationStatus ==
                                                      PermissionStatus
                                                          .permanentlyDenied ||
                                                  (locationStatus ==
                                                      PermissionStatus
                                                          .denied)) {
                                                setState(() {
                                                  Constant.locationPermission =
                                                      false;
                                                });
                                              }
                                            }
                                            /*} else {
                                              productDetailBloc.setBusy(false);
                                              if (await Geolocator
                                                      .checkPermission() ==
                                                  LocationPermission
                                                      .deniedForever) {
                                                Utils.showToastMessage(
                                                    LocaleUtils.getString(
                                                        mContext, "lct_msg"));
                                                await Geolocator
                                                    .openLocationSettings();
                                              } else {
                                                Utils.showToastMessage(
                                                    LocaleUtils.getString(
                                                        mContext, "lct_msg1"));
                                              }
                                            }*/
                                          } on Exception catch (e) {
                                            productDetailBloc.setBusy(false);
                                          }
                                        } else {
                                          Utils.showToastMessage(
                                              LocaleUtils.getString(mContext,
                                                  'no_internet_connection'));
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 15,
                                            bottom: 15),
                                        decoration: BoxDecoration(
                                          color: Color(colorPrimary),
                                          borderRadius: BorderRadius.all(
                                              const Radius.circular(5.0)),
                                        ),
                                        child: Text(
                                          'More Info',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Visibility(
                                visible: webViewScreenBloc.busy,
                                child: CustomProgressBar()),
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            left: 0.0,
                            child: Container(
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
                      )),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget textWidget(String data, Color color, bool isbold) {
    return Text(data,
        style: TextStyle(
            color: color,
            fontFamily: 'Roboto',
            fontWeight: isbold ? FontWeight.bold : FontWeight.w400,
            fontSize: 15));
  }

  Future<void> getUserLocation() async {
    try {
      currentLocation = await locateUser();
    } on Exception {
      setState(() {
        Constant.locationPermission = false;
      });
    }
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> checkPermissionData() async {
    if (!Constant.locationPermission) {
      return true;
    } else {
      if (await Permission.location.isGranted) {
        return true;
      }
    }
    /*if (await Permission.location.isGranted &&
        await Permission.camera.isGranted) {
      return true;
    }*/
    return false;
  }

  Future<void> navigatorScreen() async {
    /*if (currentLocation != null) {*/

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
    if(widget.isValid!.isNotEmpty) {
      url =
          '${widget.scanData}&MOB=${widget.mNo}&LAT=${currentLocation != null
          ? currentLocation!.latitude
          : ''}&LONG=${currentLocation != null
          ? currentLocation!.longitude
          : ''}&DVC=${await Utils.getDeviceID()}&FRM=D&LNG=1&IsValid=${widget
          .isValid}';
    } else {
      url =
          '${widget.scanData}&MOB=${widget.mNo}&LAT=${currentLocation != null
          ? currentLocation!.latitude
          : ''}&LONG=${currentLocation != null
          ? currentLocation!.longitude
          : ''}&DVC=${await Utils.getDeviceID()}&FRM=D&LNG=1';
    }
    var isBack = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => WebViewScreen(url)));

    if (isBack != null && isBack) {
      Navigator.pop(context, true);
    }
    productDetailBloc.setBusy(false);

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

  void checkFOCUser(String? varString) {
    // https://ivcs.ai/21/HVYQDOB2/10/NMZ-632?13=221008&17=241007

    if (varString!.contains('21/') &&
        varString.contains('10/') &&
        varString.contains('13=')) {
      setState(() {
        isFocUser = true;
      });
    } else {
      setState(() {
        isFocUser = false;
      });
    }
  }
}
