import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/Utils/CustomAppBar.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/ScanBloc.dart';
import 'package:flutter_basf_hk_app/components/CustomProgressBar.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';
import 'package:flutter_basf_hk_app/webservices/Constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'ProductDetailScreen.dart';
import 'WebViewScreen.dart';

class ScanScreen extends StatefulWidget {
  final String name;
  final String mNo;

  ScanScreen(this.name, this.mNo);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Size? screenSize;
  Utils? mUtils;
  SharedPrefs? sharedPrefs;

  BuildContext? mContext;

  late AnimationController controller;
  Animation<double>? scaleAnimation;
  ScanBloc? scanBloc;
  late AnimationController animationController, _animationController;
  late Animation<Offset> offset;
  late QRViewController _captureController;
  StreamSubscription<Map>? _batteryStateSubscription;
  String CHIPhER_LAB = 'CipherLab';
  double boxWidth = 270;
  double boxHeight = 250;

  Position? currentLocation;
  String? manuFacturer;

  bool _isTorchOn = false;

  late TextEditingController serialNumberController;

  late AudioCache player;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
    // if (Platform.isAndroid && manuFacturer.contains(CHIPhER_LAB)) {
    //   _battery.stopScanChiperLab();
    // }
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
    _captureController.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(_animationController);

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    super.initState();

    player = AudioCache();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    init();
    mUtils = Utils();
    sharedPrefs = SharedPrefs();
    serialNumberController = TextEditingController();
    // getUserLocation();
    // _captureController = QRViewController();
    // _batteryStateSubscription =
    //     _battery.onBatteryStateChanged.listen((Map state) async {
    //   try {
    //     print('=======state=======${state.toString()}');
    //
    //     if (state['type'] == '1001') {
    //       var detailsData = state['Details'];
    //       print('====detailsData====$detailsData');
    //       final String value = detailsData ?? '';
    //       if (value.isNotEmpty) {
    //         print('=====value=======$value');
    //         if (!scanBloc.isLoadData) {
    //           final List<String> scanList = List();
    //           if (!scanList.contains(value)) {
    //             await beepSound();
    //             // await scanBloc.setloading(true);
    //             // await getUserLocation();
    //             // await callScanApi(value.trim());
    //             await scanBloc.setScandata(value.trim());
    //           }
    //         }
    //         //}
    //       }
    //     } else if (state['type'] == '1002') {
    //       var detailsData = state['Details'];
    //       Utils.showToastMessage(detailsData);
    //     } else if (state['type'] == '1000') {
    //       var detailsData = state['Details'];
    //       Utils.showToastMessage(detailsData);
    //     }
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // });

    // _captureController.onCapture((data) async {
    //   print('-----onCapture----$data');
    //   if (!scanBloc.isLoadData) {
    //     if (data.trim().isNotEmpty) {
    //       String url = data.trim();
    //       print('====stickerUrl=====$url');
    //       // if (await Utils.checkInternetConnection(_battery)) {
    //       beepSound();
    //       if (checkUrl(data)) {
    //         scanBloc.setloading(true);
    //         // await getUserLocation();
    //         setState(() {
    //           _captureController.pauseCamera();
    //         });
    //         // await scanBloc.setBusy(true);
    //         // await callScanApi(data);
    //         await scanBloc.setScandata(data);
    //       } else {
    //         await scanBloc.setloading(true);
    //         setState(() {
    //           _captureController.pauseCamera();
    //         });
    //         await showDialog(
    //           context: context,
    //           barrierDismissible: false,
    //           builder: (BuildContext context) {
    //             return showDialogForInValid(
    //                 data, LocaleUtils.getString(mContext, "invalid_qr_code"));
    //           },
    //         );
    //       }
    //       // }
    //       // else {
    //       //   Utils.showToastMessage(
    //       //       LocaleUtils.getString(mContext, 'no_internet_connection'));
    //       // }
    //     }
    //   }
    // });

    init();
    Future.delayed(Duration(milliseconds: 2), () async {
      // await scanBloc.getScanningSummaryAPICall();
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _captureController.pauseCamera();
    } else if (Platform.isIOS) {
      _captureController.resumeCamera();
    }
  }

  init() async {
    manuFacturer = await Utils.getMenufacturer();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    print('currentLocation--- $currentLocation');
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    mContext = context;
    return ChangeNotifierProvider<ScanBloc>(
        create: (BuildContext context) => ScanBloc(context),
        child: Consumer(
            builder: (BuildContext context, ScanBloc loginBloc, Widget? child) {
          scanBloc = loginBloc;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
            child: SafeArea(
              child: AbsorbPointer(
                absorbing: loginBloc.busy,
                child: WillPopScope(
                  onWillPop: () async {
                    Utils.hideKeyBoard(context);
                    return true;
                  },
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    appBar: CustomAppBar(false, true, () {
                      Navigator.pop(context);
                    }),
                    body: Scaffold(
                        key: scaffoldKey,
                        backgroundColor: Colors.white,
                        body: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Container(
                                        color: Color(colorPrimary),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 35, bottom: 25),
                                                    child: Text(
                                                      widget.name,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Roboto',fontWeight: FontWeight.w500,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        boxWidth,
                                                                    height:
                                                                        boxHeight,
                                                                    child: Stack(
                                                                        children: [
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 25, height: 5)),
                                                                          Positioned(
                                                                              bottom: 0,
                                                                              left: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 25, height: 5)),
                                                                          Positioned(
                                                                              right: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 25, height: 5)),
                                                                          Positioned(
                                                                              bottom: 0,
                                                                              right: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 25, height: 5)),
                                                                          Positioned(
                                                                              bottom: 0,
                                                                              right: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 5, height: 25)),
                                                                          Positioned(
                                                                              bottom: 0,
                                                                              left: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 5, height: 25)),
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 5, height: 25)),
                                                                          Positioned(
                                                                              top: 0,
                                                                              right: 0,
                                                                              child: Container(color: Color(colorPrimary), width: 5, height: 25)),
                                                                        ]),
                                                                  )),
                                                              Container(
                                                                width: boxWidth,
                                                                height:
                                                                    boxHeight,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .blueAccent)),
                                                                child: QRView(
                                                                  key: qrKey,
                                                                  onQRViewCreated:
                                                                      _onQRViewCreated,
                                                                  overlay: QrScannerOverlayShape(
                                                                      borderColor:
                                                                          Color(
                                                                              colorPrimary),
                                                                      borderRadius:
                                                                          0,
                                                                      borderLength:
                                                                          30,
                                                                      borderWidth:
                                                                          10,
                                                                      cutOutSize:
                                                                          boxHeight),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: boxWidth,
                                                                height:
                                                                    boxHeight,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            40),
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    SlideTransition(
                                                                        position:
                                                                            offset,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              15.0,
                                                                          width:
                                                                              boxWidth,
                                                                          decoration: BoxDecoration(
                                                                              gradient: LinearGradient(
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end:
                                                                                Alignment.bottomCenter,
                                                                            stops: [
                                                                              0.1,
                                                                              0.2
                                                                            ],
                                                                            colors: [
                                                                              Color(colorPrimary),
                                                                              Colors.transparent
                                                                            ],
                                                                          )),
                                                                        )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            height: 33,
                                                            width: 50,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                if (_isTorchOn) {
                                                                  await _captureController
                                                                      .toggleFlash();
                                                                } else {
                                                                  await _captureController
                                                                      .toggleFlash();
                                                                }
                                                                _isTorchOn =
                                                                    !_isTorchOn;
                                                                if (mounted) {
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            25),
                                                                    width: 35,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: _isTorchOn
                                                                            ? Color(colorPrimary)
                                                                            : Colors.transparent),
                                                                  ),
                                                                  Center(
                                                                      child:
                                                                          Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(2),
                                                                    child: Image.asset(
                                                                        'assets/torch_icon.png',
                                                                        width:
                                                                            35,
                                                                        height:
                                                                            35,
                                                                        color: _isTorchOn
                                                                            ? Colors.white
                                                                            : null),
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   padding:
                                                  //       EdgeInsets.only(top: 15),
                                                  //   alignment: Alignment.center,
                                                  //   child: Text(
                                                  //     LocaleUtils.getString(
                                                  //         context, "or"),
                                                  //     style: TextStyle(
                                                  //         color: Colors.black,
                                                  //         fontSize: 18),
                                                  //   ),
                                                  // ),
                                                  // Container(
                                                  //   height: 60,
                                                  //   margin: EdgeInsets.only(
                                                  //       left: 10,
                                                  //       right: 10,
                                                  //       top: 15),
                                                  //   alignment:
                                                  //       Alignment.topCenter,
                                                  //   padding: EdgeInsets.only(
                                                  //       left: 25, right: 25),
                                                  //   child: Container(
                                                  //     decoration: BoxDecoration(
                                                  //         border: Border.all(
                                                  //             color: Color(
                                                  //                 colorPrimary))),
                                                  //     child: Row(
                                                  //       children: [
                                                  //         Expanded(
                                                  //           child: Container(
                                                  //             child: TextField(
                                                  //               controller:
                                                  //                   serialNumberController,
                                                  //               cursorColor: Color(
                                                  //                   colorPrimary),
                                                  //               decoration: InputDecoration(
                                                  //                   focusedBorder:
                                                  //                       InputBorder
                                                  //                           .none,
                                                  //                   enabledBorder:
                                                  //                       InputBorder
                                                  //                           .none,
                                                  //                   errorBorder:
                                                  //                       InputBorder
                                                  //                           .none,
                                                  //                   disabledBorder:
                                                  //                       InputBorder
                                                  //                           .none,
                                                  //                   contentPadding:
                                                  //                       EdgeInsets.only(
                                                  //                           left:
                                                  //                               15,
                                                  //                           bottom:
                                                  //                               11,
                                                  //                           top:
                                                  //                               11,
                                                  //                           right:
                                                  //                               15),
                                                  //                   hintText: LocaleUtils
                                                  //                       .getString(
                                                  //                           context,
                                                  //                           "enter_serial")),
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //         Container(
                                                  //           height: 30,
                                                  //           width: 1,
                                                  //           padding:
                                                  //               EdgeInsets.only(
                                                  //                   left: 15,
                                                  //                   right: 15),
                                                  //           color: Colors.grey,
                                                  //         ),
                                                  //         InkWell(
                                                  //           onTap: () async {
                                                  //             if (serialNumberController
                                                  //                 .text
                                                  //                 .isNotEmpty) {
                                                  //               Utils
                                                  //                   .hideKeyBoard(
                                                  //                       context);
                                                  //
                                                  //               await scanBloc
                                                  //                   .setBusy(
                                                  //                       true);
                                                  //               await getUserLocation();
                                                  //               await scanBloc
                                                  //                   .setloading(
                                                  //                       true);
                                                  //               await callScanApi(
                                                  //                   serialNumberController
                                                  //                       .text
                                                  //                       .toString()
                                                  //                       .trim());
                                                  //             } else {
                                                  //               Utils.showToastMessage(
                                                  //                   LocaleUtils.getString(
                                                  //                       mContext,
                                                  //                       "enter_serial_no"));
                                                  //             }
                                                  //           },
                                                  //           child: Container(
                                                  //               width: 30,
                                                  //               height: 30,
                                                  //               margin: EdgeInsets
                                                  //                   .only(
                                                  //                       left: 5,
                                                  //                       right: 5),
                                                  //               decoration:
                                                  //                   BoxDecoration(
                                                  //                 color: Color(
                                                  //                     colorPrimary),
                                                  //                 shape: BoxShape
                                                  //                     .circle,
                                                  //               ),
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .center,
                                                  //               child: Text(
                                                  //                 LocaleUtils
                                                  //                     .getString(
                                                  //                         mContext,
                                                  //                         "go"),
                                                  //                 style: TextStyle(
                                                  //                     color: Colors
                                                  //                         .white,
                                                  //                     fontSize:
                                                  //                         14),
                                                  //               )),
                                                  //         )
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top: 30,
                                                          left: 20,
                                                          right: 20),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          scanBloc!.scanData!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontFamily: 'Roboto',fontWeight: FontWeight.w500,
                                                              color: Colors
                                                                  .blue))),

                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top: 30,
                                                          left: 20,
                                                          right: 20),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _captureController
                                                                    .resumeCamera();
                                                              });
                                                              scanBloc!
                                                                  .setScandata(
                                                                      '');
                                                              scanBloc!
                                                                  .setloading(
                                                                      false);
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 10),
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      colorPrimary),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
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
                                                                        'Cancel_'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily: 'Roboto',fontWeight: FontWeight.w500,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              if (scanBloc!
                                                                  .scanData!
                                                                  .isNotEmpty) {
                                                                if (scanBloc!
                                                                    .isThirdParty) {
                                                                  if (await Utils
                                                                      .checkInternetConnection()) {
                                                                    var isBack = await Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                WebViewScreen(scanBloc!.scanData!)));
                                                                    if (isBack! &&
                                                                        isBack) {
                                                                      setState(
                                                                          () {
                                                                        _captureController
                                                                            .resumeCamera();
                                                                        clearData();
                                                                        scanBloc!
                                                                            .setloading(false);
                                                                        scanBloc!
                                                                            .setScandata('');
                                                                        scanBloc!
                                                                            .setThirdParty('');
                                                                      });
                                                                    }
                                                                  } else {
                                                                    Utils.showToastMessage(LocaleUtils.getString(
                                                                        mContext,
                                                                        'no_internet_connection'));
                                                                  }
                                                                } else {
                                                                  getdata(scanBloc!
                                                                      .scanData!);
                                                                  if (scanBloc!
                                                                          .uniqueData!
                                                                          .isNotEmpty &&
                                                                      checkUrl(
                                                                          scanBloc!
                                                                              .scanData)) {
                                                                    if (_isTorchOn) {
                                                                      await _captureController
                                                                          .toggleFlash();
                                                                      _isTorchOn =
                                                                          !_isTorchOn;
                                                                    }
                                                                    if (mounted) {
                                                                      setState(
                                                                          () {});
                                                                    }

                                                                    var ok = await Navigator.of(context).push(MaterialPageRoute(
                                                                        builder: (context) => ProductDetailScreen(
                                                                            scanBloc!.uniqueData,
                                                                            scanBloc!.batchNo,
                                                                            scanBloc!.mfgdate,
                                                                            scanBloc!.exdate,
                                                                            widget.mNo,
                                                                            scanBloc!.scanData,'')));

                                                                    if (ok !=
                                                                            null &&
                                                                        ok) {
                                                                      setState(
                                                                          () {
                                                                        _captureController
                                                                            .resumeCamera();
                                                                      });
                                                                      scanBloc!
                                                                          .setloading(
                                                                              false);
                                                                      scanBloc!
                                                                          .setScandata(
                                                                              '');
                                                                      scanBloc!
                                                                          .setThirdParty(
                                                                              '');
                                                                    }
                                                                  } else {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return showDialogForInValid(
                                                                            scanBloc!
                                                                                .scanData!,
                                                                            LocaleUtils.getString(mContext,
                                                                                'no_url_found'));
                                                                      },
                                                                    );
                                                                  }
                                                                }
                                                              } else {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return showDialogForInValid(
                                                                        scanBloc!
                                                                            .scanData!,
                                                                        LocaleUtils.getString(
                                                                            mContext,
                                                                            'invalid_qr_code'));
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 10,
                                                                      left: 25),
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      colorPrimary),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
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
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily: 'Roboto',fontWeight: FontWeight.w500,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                ),
                              ],
                            ),
                            Center(
                              child: Visibility(
                                visible: loginBloc.busy,
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

  Widget showDialogForInValid(String stricker, String message) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        stricker,
                        style: TextStyle(
                            fontSize: 17,fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Text(message,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold,fontFamily: 'Roboto')),
                    ),
                    InkWell(
                      onTap: () {
                        scanBloc!.setloading(false);
                        setState(() {
                          _captureController.resumeCamera();
                        });
                        clearData();
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 25, right: 25, top: 17.5, bottom: 17.5),
                            margin: EdgeInsets.only(top: 25, bottom: 25),
                            decoration: BoxDecoration(
                                color: Color(colorPrimary),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(LocaleUtils.getString(context, 'ok'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // Future<void> callScanApi(String stricker) async {
  //   // if (await Utils.checkInternetConnection(_battery)) {
  //   try {
  //     if (scanBloc != null) {
  //       if (await Geolocator.isLocationServiceEnabled()) {
  //         if (scanBloc != null) {
  //           try {
  //             if (checkValidUrl(stricker)) {
  //               stricker = stricker.substring(
  //                   stricker.lastIndexOf('/21/') + 4, stricker.length);
  //
  //               stricker = stricker.substring(0, stricker.indexOf('/'));
  //             } else {}
  //           } on Exception catch (e) {
  //             await showDialog(
  //               context: context,
  //               barrierDismissible: false,
  //               builder: (BuildContext context) {
  //                 return showDialogForInValid(stricker,
  //                     LocaleUtils.getString(mContext, "invalid_qr_code"));
  //               },
  //             );
  //           }
  //         }
  //       } else {
  //         scanBloc!.setBusy(false);
  //         if (await Geolocator.checkPermission() ==
  //             LocationPermission.deniedForever) {
  //           Utils.showToastMessage(LocaleUtils.getString(mContext, "lct_msg"));
  //           await Geolocator.openLocationSettings();
  //         } else {
  //           Utils.showToastMessage(LocaleUtils.getString(mContext, "lct_msg1"));
  //         }
  //       }
  //     }
  //   } on Exception catch (e) {
  //     scanBloc!.setloading(false);
  //     scanBloc!.setBusy(false);
  //   }
  // }

  // else {
  //   scanBloc.setloading(false);
  //   scanBloc.setBusy(false);
  //   Utils.showToastMessage(
  //       LocaleUtils.getString(mContext, 'no_internet_connection'));
  // }
  // }

  void beepSound() {
    player.play(Constant.alarmAudioPath);
    print('soundcalled');
  }

  void clearData() {
    serialNumberController.clear();
  }

  bool checkValidUrl(String url) {
    bool _validURL = false;
    try {
      _validURL = Uri.parse(url).isAbsolute;
    } on Exception catch (e) {
      _validURL = false;
    }
    return _validURL;
  }

  // Future<void> setData(String stricker) async {
  //   if (scanBloc.responseModel != null &&
  //       scanBloc.responseModel.status == "0") {
  //     scanBloc.setBusy(false);
  //     await showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return showDialogForInValid(stricker, scanBloc.responseModel.message);
  //       },
  //     );
  //   } else {
  //     await clearData();
  //     scanBloc.setBusy(false);
  //     await _captureController.pause();
  //     Utils.hideKeyBoard(context);
  //     String url = "";
  //     if (scanBloc.responseModel.getStickerInfo().isNotEmpty) {
  //       url =
  //           "${scanBloc.responseModel.getStickerInfo()[0].varQRCode}&MOB=${widget.mNo}&LAT=${currentLocation.latitude}&LONG=${currentLocation.longitude}&DVC=${await Utils.getDeviceID()}&FRM=D&LNG=1";
  //     }
  //     scanBloc.setloading(true);
  //     clearData();
  //     if (_isTorchOn) {
  //       _captureController.torchMode = CaptureTorchMode.off;
  //       _isTorchOn = !_isTorchOn;
  //     }
  //     if (mounted) {
  //       setState(() {});
  //     }
  //
  //     print("URl--" + url);
  //
  //     bool isBack = await Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => WebViewScreen(url)));
  //
  //     if (isBack != null && isBack) {
  //       scanBloc.setloading(false);
  //       await _captureController.resume();
  //     }
  //   }
  // }

  void getdata(String varString) {
    var varUniqSTR = '';
    if (varString.contains('21/')) {
      varUniqSTR =
          varString.substring(varString.indexOf('21/'), varString.length);
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
      scanBloc!.setUniqueData(data);
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
      scanBloc!.setBatchData(data1);
    }

    if (varMFGSTR.isNotEmpty) {
      var data2 = varMFGSTR.substring(
        3,
        !varMFGSTR.contains('&17=')
            ? varMFGSTR.length
            : varMFGSTR.indexOf('&17='),
      );
      scanBloc!.setMfgData(data2);
    }

    if (varEXPSTR.isNotEmpty) {
      var data3 = varEXPSTR.substring(
        3,
        varEXPSTR.length,
      );
      scanBloc!.setExData(data3);
    }
  }

  // bool checkUrl(String? scanData) {
  //   // https://c.ivcs.ai  CQA
  //   // https://i.ivcs.ai  iQA
  //   // https://ivcs.ai  PAS Link
  //   var isValid = false;
  //   if (Constant.SERVER == 'IQA') {
  //     if ((scanData!.contains('https://i.ivcs.ai') ||
  //         scanData.contains('http://i.ivcs.ai'))) {
  //       isValid = true;
  //     }
  //   } else if (Constant.SERVER == 'CQA') {
  //     if ((scanData!.contains('https://c.ivcs.ai') ||
  //         scanData.contains('http://c.ivcs.ai'))) {
  //       isValid = true;
  //     }
  //   } else if (Constant.SERVER == 'LIVE') {
  //     if ((scanData!.contains('https://ivcs.ai') ||
  //         scanData.contains('http://ivcs.ai'))) {
  //       isValid = true;
  //     }
  //   }
  //
  //   return isValid;
  // }

  bool checkUrl(String? scanData) {
    // https://c.ivcs.ai  CQA
    // https://i.ivcs.ai  iQA
    // https://ivcs.ai  PAS Link
    var isValid = false;
    if (Constant.SERVER == 'DEV') {
      if ((scanData!.contains('www.ivcs.ai'))) {
        isValid = true;
      }
    } else if (Constant.SERVER == 'IQA') {
      if ((scanData!.contains('i.ivcs.ai')) || (scanData!.contains('d2.ivcs.ai'))) {
        isValid = true;
      }
    } else if (Constant.SERVER == 'CQA') {
      if ((scanData!.contains('c.ivcs.ai'))) {
        isValid = true;
      }
    } else if (Constant.SERVER == 'LIVE') {
      if ((scanData!.contains('ivcs.ai'))) {
        isValid = true;
      }
    }

    return isValid;
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _captureController = controller;
      _captureController.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) async {
      String? data = '';
      setState(() {
        data = scanData.code;
      });
      print('-----onCapture----$data');
      if (!scanBloc!.isLoadData) {
        if (data!.trim().isNotEmpty) {
          var url = data!.trim();
          print('====stickerUrl=====$url');
          print('====validooo=====${checkUrlForThirdParty(data!)}');
          // if (await Utils.checkInternetConnection(_battery)) {
          beepSound();
          if (checkUrlForThirdParty(data!)) {
            scanBloc!.setloading(true);
            // await getUserLocation();
            setState(() {
              _captureController.pauseCamera();
            });
            if (checkUrl(data!)) {
              await scanBloc!.setScandata(data);
            } else {
              scanBloc!.setThirdParty(data!);
            }
          } else {
            scanBloc!.setloading(true);
            setState(() {
              _captureController.pauseCamera();
            });
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return showDialogForInValid(
                    data!, LocaleUtils.getString(mContext, 'no_url_found'));
              },
            );
          }
        }
      }
    });
  }

  bool checkUrlForThirdParty(String url) {
    try {
      return Uri.parse(url).isAbsolute;
    } catch (e) {
      return false;
    }
  }
}
