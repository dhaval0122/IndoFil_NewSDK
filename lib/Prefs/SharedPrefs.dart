import 'package:shared_preferences/shared_preferences.dart';

/* Shared Preferences KEY */
const PREF_FK_COUNTRYGLCODE = "fk_CountryGlCode";
const PREF_COUNTRYCODE = "CountryCode";
const PREF_COUNTRYNAME = "CountryName";
const PREF_fk_LanguageGlCode = "fk_LanguageGlCode";
const PREF_LanguageCode = "LanguageCode";
const PREF_DEVICE_ID = "deviceID";
const PREF_REMEMBER_ME = "RememberMe";
const PREF_INTGLCODE = "intGlCode";
const PREF_PARENT_GL_CODE = "parentGlCode";
const PREF_USERID = "varUserId";
const PREF_FULL_NAME = "varFullName";
const PREF_APITOKEN = "varAPIToken";
const PREF_VARPASSWORD = 'varPassword';
const PREF_LANG = 'Lang_code';
const IS_LOGIN = 'is_login';
const PREF_LOGININFO_INTLGLCODE = 'PREF_LOGININFO_INTLGLCODE';
const PREF_VERSION = 'VERSION';
const PREF_Mobile = 'mobile_number';
const PREF_IS_SDK_SCAN_ENABLE = 'isSDKScanEnable';

class SharedPrefs {
  Future<bool> setString(String key, String values) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, values);
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  Future<bool> setBool(String key, bool values) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, values);
  }

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<bool> setInt(String key, int values) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, values);
  }

  Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  Future<bool> setDouble(String key, double values) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, values);
  }

  Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0;
  }

  Future<bool> clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
