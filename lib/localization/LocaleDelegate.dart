import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/localization/Application.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';

class LocaleDelegate extends LocalizationsDelegate<LocaleUtils> {
//  const LocaleDelegate();
//
//  @override
//  bool isSupported(Locale locale) {
//    return ['en', 'hi'].contains(locale.languageCode);
//  }
//
//  @override
//  Future<LocaleUtils> load(Locale locale) async {
////    print("Load ${locale.languageCode}");
//    LocaleUtils localizations = new LocaleUtils(locale);
//    await localizations.load();
//    return localizations;
//  }
//
//  @override
//  bool shouldReload(LocaleDelegate old) => false;

  final Locale? newLocale;

  const LocaleDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<LocaleUtils> load(Locale locale) {
    return LocaleUtils.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocaleUtils> old) {
    return true;
  }
}
