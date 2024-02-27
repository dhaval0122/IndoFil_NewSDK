class StickerInfo {
  String? varQRCode;

  StickerInfo({this.varQRCode});

  StickerInfo.fromJson(Map<String, dynamic> json) {
    varQRCode = json['varQR_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varQR_Code'] = this.varQRCode;
    return data;
  }
}
