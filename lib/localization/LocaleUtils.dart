import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocaleUtils {
//  LocaleUtils(this.locale);
//
//  final Locale locale;
//
//  static LocaleUtils of(BuildContext context) {
//    return Localizations.of<LocaleUtils>(context, LocaleUtils);
//  }
//
//  Map<String, String> _sentences;
//
//  Future<bool> load() async {
//    try {
////      print('----languageCode-----${this.locale.languageCode}');
//      String data = await rootBundle
//          .loadString('resources/lang/${this.locale.languageCode}.json');
//      Map<String, dynamic> _result = json.decode(data);
//
//      this._sentences = new Map();
//      _result.forEach((String key, dynamic value) {
//        this._sentences[key] = value.toString();
//      });
//    }catch(e){
//      print(e.toString());
//    }
//
//    return true;
//  }
//
//  String trans(String key) {
//    return this._sentences[key];
//  }
//
//  static String getString(BuildContext mContext, String key) {
//    try {
//      if (mContext == null) {
////        print("##### getString ##### mContext=null");
//        return "";
//      }
//      return of(mContext).trans(key);
//    } catch (e) {
////      print('##### getString ##### EXCEPTION  $e');
//      return "";
//    }
//  }

  late Locale locale;
  static Map<dynamic, dynamic>? _localisedValues;

  LocaleUtils(Locale locale) {
    this.locale = locale;
  }

//  LocaleUtils(this.locale);

//  final Locale locale;

  static LocaleUtils? of(BuildContext context) {
    return Localizations.of<LocaleUtils>(context, LocaleUtils);
  }

  static Future<LocaleUtils> load(Locale locale) async {
    LocaleUtils appTranslations = LocaleUtils(locale);
    String jsonContent =
        await rootBundle.loadString("assets/lang/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  static String getString(BuildContext? mContext, String key) {
    return _localisedValues![key] ?? "$key not found";
  }
}
