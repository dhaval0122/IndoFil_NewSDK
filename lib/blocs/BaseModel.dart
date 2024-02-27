import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/styles/theme.dart';

class BaseModel with ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  ThemeData currentTheme = ThemeData();

  setGreenTheme() {
    currentTheme = greenTheme;
    // FlutterStatusbarcolor.setStatusBarColor(currentTheme.primaryColor);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return notifyListeners();
  }

  setLightBlueTheme() {
    currentTheme = lightBlueTheme;
    // FlutterStatusbarcolor.setStatusBarColor(currentTheme.primaryColor);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return notifyListeners();
  }

  setYellowTheme() {
    currentTheme = yellowTheme;
    // FlutterStatusbarcolor.setStatusBarColor(currentTheme.primaryColor);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return notifyListeners();
  }

  setOrangeTheme() {
    currentTheme = orangeTheme;
    // FlutterStatusbarcolor.setStatusBarColor(currentTheme.primaryColor);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return notifyListeners();
  }
}
