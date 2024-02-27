class MobileOREmailVerify {
  String? isEnable;
  String? intOTPTimer;
  String? isSDKScanEnable = 'Y';

  MobileOREmailVerify({this.isEnable, this.intOTPTimer,this.isSDKScanEnable});

  MobileOREmailVerify.fromJson(Map<String, dynamic> json) {
    isEnable = json['isEnable'];
    intOTPTimer = json['intOTPResendTimer'];
    isSDKScanEnable = json['isSDKScanEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEnable'] = this.isEnable;
    data['intOTPResendTimer'] = this.intOTPTimer;
    data['isSDKScanEnable'] = this.isSDKScanEnable;
    return data;
  }
}
