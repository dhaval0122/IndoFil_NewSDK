import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/UI/SplashScreen.dart';
import 'package:flutter_basf_hk_app/blocs/MobileNumberBloc.dart';
import 'package:flutter_basf_hk_app/localization/Application.dart';
import 'package:flutter_basf_hk_app/localization/LocaleDelegate.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: const Color(colorPrimary), // navigation bar color
    statusBarColor: const Color(colorPrimary), // status bar color
  ));

  runApp(LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  LocaleDelegate? _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = LocaleDelegate(newLocale: Locale('en'));
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MobileNumberBloc>(
              create: (_) => MobileNumberBloc(context)),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            _newLocaleDelegate!,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale("en", ""),
          ],
          theme: appTheme,
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = LocaleDelegate(newLocale: locale);
    });
  }
}
