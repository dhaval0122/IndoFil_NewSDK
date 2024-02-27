import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/UI/MobileNumberScreen.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/localization/Application.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size screenSize;
  late SharedPrefs sharedPrefs;
  Utils? mUtils;
  BuildContext? mContext;

  startTime() async {
    var _duration = Duration(seconds: splash_duration);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    await Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => MobileNumberScreen()));
  }

  void select() async {
    var lang = await sharedPrefs.getString(PREF_LANG);
    if (lang.isNotEmpty) {
      print('lang first==${await sharedPrefs.getString(PREF_LANG)}');
      onLocaleChange(Locale(lang));
    }
  }

  void onLocaleChange(Locale locale) {
    print('lang2==${locale}');
    setState(() {
      print('lang==${locale}');
      application.onLocaleChanged(locale);
    });
    setState(() {});
  }

  // void checkScreenLock() async {
  //   bool isKeptOn = await Screen.isKeptOn;
  //   if (!isKeptOn) {
  //     await Screen.keepOn(true);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // checkScreenLock();
    sharedPrefs = SharedPrefs();
    mUtils = Utils();

    startTime();
    select();
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    screenSize = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
      child: Scaffold(
        body: SafeArea(
          child: Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(color: const Color(colorPrimary)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Utils.getSplashProjectIcon(),
                    width: login_logo_120,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    // 'Chanel Performance\nManagement',
                    'Channel Performance\nManagement',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600),
                  ),
                  Visibility(
                    visible: false,
                    child: Image.asset(
                      Utils.getSplashSubProjectIcon(),
                      width: splash_logo_140,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
