class ProductInfoLink {
  String? varQRCode;

  ProductInfoLink({this.varQRCode});

  ProductInfoLink.fromJson(Map<String, dynamic> json) {
    varQRCode = json['varQR_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['varQR_Code'] = this.varQRCode;
    return data;
  }
}
