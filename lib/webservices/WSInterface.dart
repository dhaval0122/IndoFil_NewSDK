abstract class WSInterface {
  void onLoginSuccess(String response);

  void onLoginError(String errorTxt);
}

abstract class PushNotificationListener {
  void onLoadNotificationCount(String response);
}
