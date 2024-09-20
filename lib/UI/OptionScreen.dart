import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
// import 'package:flutter_basf_hk_app/components/FadeBUAnimation.dart';
import 'package:flutter_basf_hk_app/components/LengthLimitingTextFieldFormatterFixed.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../components/ButtonWidgets.dart';
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
              // optionScreenBloc.setBusy(true);
            } else if (state['type'] == '888') {
              optionScreenBloc.setBusy(false);
              print('==========8888888888888========');
            } else if (state['type'] == '999') {
              optionScreenBloc.setBusy(false);
              var data = state['Details'].toString();
              print('==========data========$data');
              // if(!isShowDialog) {
              // await showReceiveDialog();
              // }

              try {
                // String jsonString = '{"extendedData": "{\"ver\":\"SecureQR v2.0.95\",\"text\":\"http://c3.ivcs.ai/21/G4H1A0GJDGUZYKOA\",\"externalText\":\"\",\"resultCode\":33,\"extendedCode\":6,\"format\":\"11\",\"externalFormat\":\"\",\"certified\":false,\"re\":1,\"flash\":true,\"focus\":false,\"lens\":-1.000000,\"da\":\"3004850636362\",\"fd\":\"300575761\",\"t1\":72.000000,\"cea\":\"\",\"tm\":\"b=motorola,m=motorola one power,o=29,ev=tv,ce=n0,pos=t,-8.0-8.00,-8.0-8.00,cur=n-1,bind=n,ssv=n,re=2012333333,tvp=72,0,0,0,0,2080,0,3,0,300,72,72,1,1,22,1,24,1,70,40,,ep=n,ssp=n\",\"bind\":false,\"bind_type\":\"\",\"bind_label\":\"\",\"bind_value\":\"\",\"bind_detected\":false,\"bind_detected_value\":\"\",\"off\":{\"db\":{\"co\":0,\"st\":\"7\"},\"ne\":{\"co\":1001,\"st\":\"0\"}}}"}';

                // Decode JSON
                if(data.isNotEmpty) {
                  Map<String, dynamic> jsonMap = jsonDecode(data.toString());

                  // Convert extendedData to Dart Map
                  Map<String, dynamic> extendedData = jsonDecode(
                      jsonMap['extendedData']);

                  // Create an instance of SecureQRData from the JSON
                  SecureQRData secureQRData = SecureQRData.fromJson(
                      extendedData);

                  print('====text=====${secureQRData.text}');
                  print('====resultCode=====${secureQRData.resultCode}');
                  // print('====resultCode=====$resultCode');

                  await performScanOwn(
                      data, secureQRData.text,
                      secureQRData.resultCode.toString());
                } else {
                  optionScreenBloc.setBusy(false);
                  await showReceiveDialog();
                }
              }catch(e){
                print('==========data========${e.toString()}');
                optionScreenBloc.setBusy(false);
                await showReceiveDialog();
              }

            } else if (state['type'] == '211') {
              // var data = state['Details'];
              // Utils.showToastMessage(data.toString());
              optionScreenBloc.setBusy(true);
            } else if (state['type'] == '311') {
              var data = state['Details'];
              optionScreenBloc.setBusy(false);
              // Utils.showToastMessage(data.toString());
            } else if (state['type'] == '411') {
              optionScreenBloc.setBusy(false);
              var data = state['Details'].toString();
              // Utils.showToastMessage(data.toString());
              if(data.isNotEmpty){

                // Step 1: Parse the JSON string into a Map
                Map<String, dynamic> jsonData = jsonDecode(data);

                // Step 2: Convert the Map to the ScanData model using fromJson
                var scanData = ScanData.fromJson(jsonData);

                // Now you can access the data in the scanData object
                print('===scanResult====${scanData.scanResult}');   // Output: result_value
                print('===scanMessage====${scanData.scanMessage}');   // Output: result_value
                print('===scanTextData====${scanData.scanTextData}');   // Output: result_value
                // print(scanData.scanMessage);  // Output: message_value
                // print(scanData.scanTextData); // Output: text_data_value
                // Utils.showToastMessage(scanData.scanResult!);

                // Utils.showToastMessage(scanData.scanTextData!);

                await performScanOwn(data,scanData.scanTextData.toString(),scanData.scanResult.toString());

                // if(scanData.scanResult == '0'){
                //   isValid = 'Y';
                //   navigateToAuthenticScreen('https://va1.ecubix.com/web/genuine.php');
                // } else if(scanData.scanResult == '1'){
                //   isValid = 'N';
                //   navigateToAuthenticScreen('https://va1.ecubix.com/web/fake.php');
                // } else {
                //   // Utils.showToastMessage(scanData.scanMessage!);
                //   optionScreenBloc.setBusy(false);
                //   // await showReceiveDialog();
                // }

              }

            }
          } catch (e) {
            print('====Catch=======${e.toString()}');
            // try {
            // setState(() {
            //   _loading = false;
            // });
            optionScreenBloc.setBusy(false);
            // }catch(e){
            //   print(e.toString());
            // }

            // print('==========showReceiveDialog========$isShowDialog');
            // if(!isShowDialog) {
            await showReceiveDialog();
            // }
          }
        // });

      /*try {
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

                  print("test--" + currentLocation.toString());

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

                        navigateToAuthenticScreen();

                    }
                  } else {

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
      }*/
    });
  }

  Future<void> performScanOwn(String scanData,String result, String resultCode) async {

    try {
      // Define API URL pointing to scan.php
      var url = 'https://hpcldemotesting.ecubix.com:4452/api/scan.php';
      print('URL: $url');

      // Prepare the API request body with proper fields
      Map<String, dynamic> body = {
        'device_name': Platform.isIOS ? 'iPhone' : 'Android', // Replace with actual device name or fetch programmatically
        'device_type': Platform.isIOS ? 'IOS' : 'Android', // Replace with actual device type
        'imei': await Utils.getDeviceID(), // Replace with actual IMEI number
        'location_lat': '0', // Replace with actual latitude
        'location_lng': '0', // Replace with actual longitude
        'scancode': scanData,
        'result_value': result,
        'result_code': resultCode,
        'user_id': Platform.isIOS ? '-1' : '1', // Replace with actual user ID
      };

      // Define headers
      var headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded', // Form-urlencoded as expected by PHP
        'X-ApiKey': 'i3BalYxQL' // Replace with actual API key if needed
      };

      print('===body====${body.toString()}');

      // API Call using http with form-urlencoded body
      final response = await http.post(
        Uri.parse(url),
        body: body, // No need to jsonEncode for form-urlencoded
        headers: headers,
      ).timeout(Duration(minutes: 6));
      // print('===response====${response.toString()}');
      // Handle the response

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('===responseBody====${responseBody.toString()}');
        // Safely access fields with null-checks and provide default values
        bool status = responseBody['status'] ?? false;
        String message = responseBody['message'] ?? 'No message provided';
        String responseCode = responseBody['response_code'] ?? '-1';

        if (status) {
          String responseResult = '';
          if (responseCode == '0') {
            responseResult = "Pass";
            navigateToAuthenticScreen('https://va1.ecubix.com/web/genuine.php');
          } else if (responseCode == '1') {
            responseResult = "Fail";
            navigateToAuthenticScreen('https://va1.ecubix.com/web/fake.php');
          } else if (responseCode == '-1') {
            responseResult = "Retry";
            optionScreenBloc.setBusy(false);
            await showReceiveDialog();
          }
          print("responseResult: $responseResult");
          print("responseCode: $responseCode");
        } else {
          print('Status is false: $message');
        }
      } else {
        print('Error: ${response.statusCode} ${response.reasonPhrase}');
      }

    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  showReceiveDialog() async {
    // isShowDialog = true;
    await showDialog(
      barrierDismissible: false,
      context: mContext!,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.white),
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/retry_anim.json', width: 150,
                    height: 150),
                 Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '• Keep your hand steady while capturing the image.\n'
                            '• Make sure the image remains clear and is not blurred.\n'
                            '• Ensure proper lighting while capturing the image.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      Expanded(
                        flex: 1,
                        child: ButtonWidgets(
                          buttonName: 'Retry',
                          buttonColor: Color(colorPrimary),
                          textColor: Colors.white,
                          onTap: () async {
                            // isShowDialog = false;
                            Navigator.of(context).pop();

                            var isConnection = await _battery.checkInternet();
                            if (isConnection.contains('true')) {
                              // dispatchInfo = '';
                              // CameraScanScreenState.scanStciker.clear();
                              //
                              // var batchInfo = DeliveryModel(
                              //   customerName: customerDetailsTxtController.text.trim(),
                              //   mobileNumber: mobileNoTxtController.text.trim(),
                              //   isDeliver: 'N',
                              //   stickers: [],
                              // );
                              //
                              // // Convert BatchInfo object to JSON string
                              // dispatchInfo = jsonEncode(batchInfo.toJson());
                              // print('===Delivery Info====$dispatchInfo');

                              isValid = '';
                              // pData = '';
                              if(Platform.isIOS) {
                                await _battery.scanSecureQRCodeIOS();
                              } else {
                                await _battery.scanQRCodeViaSDK();
                              }
                            } else {
                              Utils.showToastMessage(
                                  LocaleUtils.getString(
                                      mContext,
                                      'no_internet_connection'));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToAuthenticScreen(String urlVal) async{
      // only for dev
      // print("print===${widget.scanData!.contains("https://www.ivcs.ai:8090")}");
      // if(widget.scanData!.contains('https://www.ivcs.ai:8090')){
      //   widget.scanData=widget.scanData!.replaceAll('https://www.ivcs.ai:8090','http://172.16.10.70/eCubix_Product_Info');
      //   setState(() {
      //
      //   });
      // }
      // print("widget.scanData===${widget.scanData}");

      // var url;
      // if(isValid!.isNotEmpty) {
      //   url =
      //   '${optionScreenBloc.url}&MOB=${widget.mNo}&LAT=${currentLocation != null
      //       ? currentLocation!.latitude
      //       : ''}&LONG=${currentLocation != null
      //       ? currentLocation!.longitude
      //       : ''}&DVC=${await Utils.getDeviceID()}&FRM=D&LNG=1&IsValid=$isValid';
      // } else {
      //   url =
      //   '${optionScreenBloc.url}&MOB=${widget.mNo}&LAT=${currentLocation != null
      //       ? currentLocation!.latitude
      //       : ''}&LONG=${currentLocation != null
      //       ? currentLocation!.longitude
      //       : ''}&DVC=${await Utils.getDeviceID()}&FRM=D&LNG=1';
      // }
      var isBack = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => WebViewScreen(urlVal)));

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
                                          // borderRadius: BorderRadius.only(
                                          //     topLeft: Radius.circular(25),
                                          //     topRight: Radius.circular(20))
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Visibility(
                                                  visible: false,
                                                  child: Container(
                                                    child: Column(
                                                      children: [

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
                                                            ),

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

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: false,
                                                  child:
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
                                                      ),
                                                ),

                                                    InkWell(
                                                      onTap: () async {
                                                        // await Navigator.of(
                                                        //     context)
                                                        //     .push(MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         WebViewScreen('http://c3.ivcs.ai/21/AAPPPAKD0UOOC9RX/10/QRTEST?11=231018&17=300101&MOB=9033486861&LAT=23.051017&LONG=72.4898316&DVC=0f562546c8c7a946&FRM=D&LNG=1&IsValid=Y')));

                                                        // var isSDKScan =
                                                        //     await sharedPrefs
                                                        //         .getString(
                                                        //             PREF_IS_SDK_SCAN_ENABLE);
                                                        // if (isSDKScan == 'Y') {
                                                          isValid = '';
                                                          // await _battery
                                                          //     .scanSecureQRCodeIOS();
                                                          if(Platform.isIOS) {
                                                            await _battery.scanSecureQRCodeIOS();
                                                          } else {
                                                            await _battery.scanQRCodeViaSDK();
                                                          }
                                                        // } else {
                                                        //   if (widget
                                                        //       .mNo.isNotEmpty) {
                                                        //     if (widget.mNo
                                                        //             .length ==
                                                        //         10) {
                                                        //       if (await Geolocator
                                                        //           .isLocationServiceEnabled()) {
                                                        //         if (await Utils
                                                        //             .checkInternetConnection()) {
                                                        //           if (await checkPermissionData()) {
                                                        //             try {
                                                        //               // await getUserLocation();
                                                        //             } catch (e) {
                                                        //               print(e
                                                        //                   .toString());
                                                        //             }
                                                        //
                                                        //             await Navigator.of(context).push(MaterialPageRoute(
                                                        //                 builder: (context) => ScanScreen(
                                                        //                     widget.name,
                                                        //                     widget.mNo)));
                                                        //           } else {
                                                        //             var status =
                                                        //                 await getCameraPermission();
                                                        //             if (status ==
                                                        //                 PermissionStatus
                                                        //                     .permanentlyDenied) {
                                                        //               await openAppSettings();
                                                        //             } else {
                                                        //               var status =
                                                        //                   await getCameraPermission();
                                                        //               if (status ==
                                                        //                   PermissionStatus
                                                        //                       .permanentlyDenied) {
                                                        //                 await openAppSettings();
                                                        //               }
                                                        //             }
                                                        //           }
                                                        //         } else {
                                                        //           Utils.showToastMessage(
                                                        //               LocaleUtils.getString(
                                                        //                   mContext,
                                                        //                   'no_internet_connection'));
                                                        //         }
                                                        //       }
                                                        //     }
                                                        //   }
                                                        // }
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.only(
                                                          left: 20,
                                                          top: 50,
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

class ScanData {
  String? scanResult;
  String? scanMessage;
  String? scanTextData;

  ScanData({this.scanResult, this.scanMessage, this.scanTextData});

  // Factory method to create an instance from a JSON map
  factory ScanData.fromJson(Map<String, dynamic> json) {
    return ScanData(
      scanResult: json['scanResult'],
      scanMessage: json['scanMessage'],
      scanTextData: json['scanTextData'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'scanResult': scanResult,
      'scanMessage': scanMessage,
      'scanTextData': scanTextData,
    };
  }
}

class SecureQRData {
  final String ver;
  final String text;
  final String externalText;
  final int resultCode;
  final int extendedCode;
  final String format;
  final String externalFormat;
  final bool certified;
  final int re;
  final bool flash;
  final bool focus;
  final double lens;
  final String da;
  final String fd;
  final double t1;
  final String cea;
  final String tm;
  final bool bind;
  final String bindType;
  final String bindLabel;
  final String bindValue;
  final bool bindDetected;
  final String bindDetectedValue;
  final Off off;

  SecureQRData({
    required this.ver,
    required this.text,
    required this.externalText,
    required this.resultCode,
    required this.extendedCode,
    required this.format,
    required this.externalFormat,
    required this.certified,
    required this.re,
    required this.flash,
    required this.focus,
    required this.lens,
    required this.da,
    required this.fd,
    required this.t1,
    required this.cea,
    required this.tm,
    required this.bind,
    required this.bindType,
    required this.bindLabel,
    required this.bindValue,
    required this.bindDetected,
    required this.bindDetectedValue,
    required this.off,
  });

  factory SecureQRData.fromJson(Map<String, dynamic> json) {
    return SecureQRData(
      ver: json['ver'],
      text: json['text'],
      externalText: json['externalText'],
      resultCode: json['resultCode'],
      extendedCode: json['extendedCode'],
      format: json['format'],
      externalFormat: json['externalFormat'],
      certified: json['certified'],
      re: json['re'],
      flash: json['flash'],
      focus: json['focus'],
      lens: json['lens'].toDouble(),
      da: json['da'],
      fd: json['fd'],
      t1: json['t1'].toDouble(),
      cea: json['cea'],
      tm: json['tm'],
      bind: json['bind'],
      bindType: json['bind_type'],
      bindLabel: json['bind_label'],
      bindValue: json['bind_value'],
      bindDetected: json['bind_detected'],
      bindDetectedValue: json['bind_detected_value'],
      off: Off.fromJson(json['off']),
    );
  }
}

class Off {
  final Db db;
  final Ne ne;

  Off({
    required this.db,
    required this.ne,
  });

  factory Off.fromJson(Map<String, dynamic> json) {
    return Off(
      db: Db.fromJson(json['db']),
      ne: Ne.fromJson(json['ne']),
    );
  }
}

class Db {
  final int co;
  final String st;

  Db({
    required this.co,
    required this.st,
  });

  factory Db.fromJson(Map<String, dynamic> json) {
    return Db(
      co: json['co'],
      st: json['st'],
    );
  }
}

class Ne {
  final int co;
  final String st;

  Ne({
    required this.co,
    required this.st,
  });

  factory Ne.fromJson(Map<String, dynamic> json) {
    return Ne(
      co: json['co'],
      st: json['st'],
    );
  }
}



