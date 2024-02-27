abstract class ResponseListener {
  void onSuccess(String methodName, dynamic response);

  void onFailure(String methodName, String errorTxt);
}
