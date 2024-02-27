class LoginInfo {
  var intGlCode;

  LoginInfo({this.intGlCode});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    intGlCode = json['intGlCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['intGlCode'] = this.intGlCode;
    return data;
  }
}
