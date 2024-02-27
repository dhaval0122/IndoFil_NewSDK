class BASFContactInformation {
  String? varBASFContactNo;

  BASFContactInformation({this.varBASFContactNo});

  BASFContactInformation.fromJson(Map<String, dynamic> json) {
    varBASFContactNo = json['varBASFContactNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varBASFContactNo'] = this.varBASFContactNo;
    return data;
  }
}
