import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/UI/OptionScreen.dart';
import 'package:flutter_basf_hk_app/Utils/CustomAppBar.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
// import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../Prefs/SharedPrefs.dart';
import '../Utils/Utils.dart';
import '../blocs/OTPBloc.dart';
import '../components/CountDownTimer.dart';
import '../components/CustomProgressBar.dart';
import '../localization/LocaleUtils.dart';

class OTPScreen extends StatefulWidget {
  final String? mobileNumber;
  final String? oTPConfigTimer;

  OTPScreen(this.mobileNumber, this.oTPConfigTimer);

  @override
  _OTPScreenScreenState createState() => _OTPScreenScreenState();
}

class _OTPScreenScreenState extends State<OTPScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isTimeFinish = false;
  OTPBloc? otpBloc;
  late SharedPrefs sharedPrefs;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs = SharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OTPBloc>(
        create: (BuildContext context) => OTPBloc(context),
        child: Consumer(
            builder: (BuildContext context, OTPBloc otpBloc, Widget? child) {
          this.otpBloc = otpBloc;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
            child: SafeArea(
              child: Scaffold(
                appBar: CustomAppBar(false, true, () {
                  Navigator.pop(context, false);
                }),
                resizeToAvoidBottomInset: false,
                body: AbsorbPointer(
                  absorbing: otpBloc.busy,
                  child: WillPopScope(
                    onWillPop: () async {
                      Navigator.pop(context, false);
                      return true;
                    },
                    child: Container(
                      color: Color(colorPrimary),
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(20))),
                        child: Stack(
                          children: [
                            Column(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          LocaleUtils.getString(
                                              context, 'enter_otp'),
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xFF657080),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Form(
                                            key: formKey,
                                            child: Container(),
                                            // child: Pinput(
                                            //   length: 6,
                                            //   controller: pinController,
                                            //   focusNode: focusNode,
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.center,
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   inputFormatters: [
                                            //     FilteringTextInputFormatter
                                            //         .digitsOnly
                                            //   ],
                                            //   submittedPinTheme: PinTheme(
                                            //     height: 60.0,
                                            //     width: 50.0,
                                            //     textStyle: const TextStyle(
                                            //       fontSize: 22,
                                            //         fontFamily: 'Roboto',fontWeight: FontWeight.w400,
                                            //       color: Color(colorPrimary),
                                            //     ),
                                            //     decoration: BoxDecoration(
                                            //       shape: BoxShape.rectangle,
                                            //       // color: Color(0xFF46CCB4),
                                            //       color: Colors.white,
                                            //       borderRadius:
                                            //           BorderRadius.circular(8),
                                            //       border: Border.all(
                                            //         color: Color(colorPrimary),
                                            //         width: 1.0,
                                            //       ),
                                            //     ),
                                            //   ),
                                            //   followingPinTheme: PinTheme(
                                            //     height: 60.0,
                                            //     width: 50.0,
                                            //     decoration: BoxDecoration(
                                            //       shape: BoxShape.rectangle,
                                            //       borderRadius:
                                            //           BorderRadius.circular(8),
                                            //       border: Border.all(
                                            //         color: Color(colorPrimary),
                                            //         width: 1.0,
                                            //       ),
                                            //     ),
                                            //   ),
                                            //   focusedPinTheme: PinTheme(
                                            //     height: 60.0,
                                            //     width: 50.0,
                                            //     textStyle: const TextStyle(
                                            //       fontSize: 22,
                                            //       color: Colors.black,
                                            //       fontFamily: 'Roboto',fontWeight: FontWeight.w400,
                                            //     ),
                                            //     decoration: BoxDecoration(
                                            //       shape: BoxShape.rectangle,
                                            //       borderRadius:
                                            //           BorderRadius.circular(8),
                                            //       color: Colors.white,
                                            //       border: Border.all(
                                            //         color: Color(colorPrimary),
                                            //         width: 1.0,
                                            //       ),
                                            //     ),
                                            //   ),
                                            //   onCompleted: (pin) async {
                                            //     debugPrint('onCompleted: $pin');
                                            //     if (pin.length == 6) {
                                            //       if (await Utils
                                            //           .checkInternetConnection()) {
                                            //         await otpBloc.callVerifyAPI(
                                            //             widget.mobileNumber!,
                                            //             pin);
                                            //
                                            //         if (otpBloc.responseModel !=
                                            //                 null &&
                                            //             otpBloc.responseModel!
                                            //                     .status ==
                                            //                 '1') {
                                            //           await sharedPrefs.setString(
                                            //               PREF_Mobile,
                                            //               widget.mobileNumber!);
                                            //
                                            //           bool isOkay = await Navigator.push(
                                            //               context,
                                            //               PageRouteBuilder(
                                            //                   transitionDuration:
                                            //                       Duration(
                                            //                           seconds:
                                            //                               1),
                                            //                   pageBuilder: (_,
                                            //                           __,
                                            //                           ___) =>
                                            //                       OptionScreen(
                                            //                           'Scan QR Code',
                                            //                           widget
                                            //                               .mobileNumber!)));
                                            //           if (isOkay) {
                                            //             Navigator.pop(
                                            //                 context, isOkay);
                                            //           }
                                            //         } else {
                                            //           Utils.showToastMessage(
                                            //               otpBloc.responseModel!
                                            //                   .message!);
                                            //         }
                                            //       } else {
                                            //         Utils.showToastMessage(
                                            //             LocaleUtils.getString(
                                            //                 context,
                                            //                 'no_internet_connection'));
                                            //       }
                                            //     }
                                            //   },
                                            //   onChanged: (value) {
                                            //     debugPrint('onChanged: $value');
                                            //   },
                                            // ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          alignment: Alignment.center,
                                          child: Text(
                                            LocaleUtils.getString(
                                                context, 'otp_message'),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Roboto',
                                                color: Color(0xFF657080),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Visibility(
                                          visible: isTimeFinish,
                                          replacement: CountDownTimer(
                                            secondsRemaining: int.parse(
                                                    widget.oTPConfigTimer!) *
                                                60,
                                            whenTimeExpires: () {
                                              setState(() {
                                                isTimeFinish = true;
                                              });
                                              focusNode.requestFocus();
                                            },
                                            countDownTimerStyle: TextStyle(
                                              color: Color(0xFF657080),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0,
                                              height: 1.2,
                                            ),
                                          ),
                                          child: InkWell(
                                            child: Text(
                                              LocaleUtils.getString(
                                                  context, 'resend'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(colorPrimary),
                                                  fontFamily: 'Roboto',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onTap: () async {
                                              if (await Utils
                                                  .checkInternetConnection()) {
                                                await otpBloc.OTPGenerate(
                                                    widget.mobileNumber!);
                                                if (otpBloc.responseModel!
                                                        .status ==
                                                    '1') {
                                                  Utils.showToastMessage(otpBloc
                                                      .responseModel!.message!);
                                                  pinController.clear();
                                                  setState(() {
                                                    isTimeFinish = false;
                                                  });
                                                  Utils.showToastMessage(otpBloc
                                                      .responseModel!.message!);
                                                }
                                              } else {
                                                Utils.showToastMessage(
                                                    LocaleUtils.getString(
                                                        context,
                                                        'no_internet_connection'));
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Visibility(
                                visible: otpBloc.busy,
                                child: CustomProgressBar(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
