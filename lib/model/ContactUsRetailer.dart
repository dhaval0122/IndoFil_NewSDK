class ContactUsRetailer {
  int? fkCustomerGlCode;
  String? varOrganizationName;
  String? varMobileNo;
  String? varEmail;

  ContactUsRetailer(
      {this.fkCustomerGlCode,
      this.varOrganizationName,
      this.varMobileNo,
      this.varEmail});

  ContactUsRetailer.fromJson(Map<String, dynamic> json) {
    fkCustomerGlCode = json['fk_CustomerGlCode'];
    varOrganizationName = json['varOrganizationName'];
    varMobileNo = json['varMobileNo'];
    varEmail = json['varEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fk_CustomerGlCode'] = this.fkCustomerGlCode;
    data['varOrganizationName'] = this.varOrganizationName;
    data['varMobileNo'] = this.varMobileNo;
    data['varEmail'] = this.varEmail;
    return data;
  }
}
