class Country {
  int? fkCountryGlCode;
  String? varCountryCode;
  String? varCountryName;

  Country({this.fkCountryGlCode, this.varCountryCode, this.varCountryName});

  Country.fromJson(Map<String, dynamic> json) {
    fkCountryGlCode = json['fk_CountryGlCode'];
    varCountryCode = json['varCountryCode'];
    varCountryName = json['varCountryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fk_CountryGlCode'] = this.fkCountryGlCode;
    data['varCountryCode'] = this.varCountryCode;
    data['varCountryName'] = this.varCountryName;
    return data;
  }
}

class CustomerType {
  int? fkCustomerTypeRegionalGlCode;
  int? fkCustomerTypeRegionalGlCode1;
  String? varCustomerLevel;
  String? varCustomerTypeCode;
  String? varCustomerTypeName;

  CustomerType(
      {this.fkCustomerTypeRegionalGlCode,
      this.fkCustomerTypeRegionalGlCode1,
      this.varCustomerLevel,
      this.varCustomerTypeCode,
      this.varCustomerTypeName});

  CustomerType.fromJson(Map<String, dynamic> json) {
    fkCustomerTypeRegionalGlCode = json['fk_Customer_Type_RegionalGlCode'];
    fkCustomerTypeRegionalGlCode1 = json['fk_Customer_Type_RegionalGlCode1'];
    varCustomerLevel = json['varCustomer_Level'];
    varCustomerTypeCode = json['varCustomer_Type_Code'];
    varCustomerTypeName = json['varCustomer_Type_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_Customer_Type_RegionalGlCode'] = this.fkCustomerTypeRegionalGlCode;
    data['fk_Customer_Type_RegionalGlCode1'] =
        this.fkCustomerTypeRegionalGlCode1;
    data['varCustomer_Level'] = this.varCustomerLevel;
    data['varCustomer_Type_Code'] = this.varCustomerTypeCode;
    data['varCustomer_Type_Name'] = this.varCustomerTypeName;
    return data;
  }
}
