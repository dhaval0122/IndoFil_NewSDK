class CustomerInformation {
  int? fkCustomerGlCode;
  String? varSAPCode;
  String? varOrganizationName;
  String? varFullName;
  String? varMobileNo;
  String? varEmail;
  String? varAddress;
  String? varPincode;
  double? decDistance;
  String? varlatitude;
  String? varlongitude;

  CustomerInformation(
      {this.fkCustomerGlCode,
      this.varSAPCode,
      this.varOrganizationName,
      this.varFullName,
      this.varMobileNo,
      this.varEmail,
      this.varAddress,
      this.varPincode,
      this.decDistance,
      this.varlatitude,
      this.varlongitude});

  CustomerInformation.fromJson(Map<String, dynamic> json) {
    fkCustomerGlCode = json['fk_CustomerGlCode'];
    varSAPCode = json['varSAPCode'];
    varOrganizationName = json['varOrganizationName'];
    varFullName = json['varFullName'];
    varMobileNo = json['varMobileNo'];
    varEmail = json['varEmail'];
    varAddress = json['varAddress'];
    varPincode = json['varPincode'];
    decDistance = json['decDistance'];
    varlatitude = json['varlatitude'];
    varlongitude = json['varlongitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_CustomerGlCode'] = this.fkCustomerGlCode;
    data['varSAPCode'] = this.varSAPCode;
    data['varOrganizationName'] = this.varOrganizationName;
    data['varFullName'] = this.varFullName;
    data['varMobileNo'] = this.varMobileNo;
    data['varEmail'] = this.varEmail;
    data['varAddress'] = this.varAddress;
    data['varPincode'] = this.varPincode;
    data['decDistance'] = this.decDistance;
    return data;
  }
}
