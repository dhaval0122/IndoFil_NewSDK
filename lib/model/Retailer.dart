class Retailer {
  String? intId;
  String? intUserId;
  String? varName;
  String? mobileNo;
  String? varUserType;

  Retailer(
      {this.intId,
      this.intUserId,
      this.varName,
      this.mobileNo,
      this.varUserType});

  Retailer.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intUserId = json['intUserId'];
    varName = json['varName'];
    mobileNo = json['mobileNo'];
    varUserType = json['varUserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intUserId'] = this.intUserId;
    data['varName'] = this.varName;
    data['mobileNo'] = this.mobileNo;
    data['varUserType'] = this.varUserType;
    return data;
  }
}
