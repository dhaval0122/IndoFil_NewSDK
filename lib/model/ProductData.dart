class ProductDataList {
  String? product_sku_code;
  String? product_sku_name;

  ProductDataList({this.product_sku_code, this.product_sku_name});

  ProductDataList.fromJson(Map<String, dynamic> json) {
    product_sku_code = json['product_sku_code'];
    product_sku_name = json['product_sku_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_sku_code'] = this.product_sku_code;
    data['product_sku_name'] = this.product_sku_name;
    return data;
  }
}

class DataList {
  int? fkSchemeGlCode;
  int? fkDefineSchemeGlCode;
  String? varSchemeCode;
  String? varSchemeName;
  String? varPointBasedOn;
  String? varGroupCode;
  String? varProductSKUCode;
  String? varProductSKUName;
  String? dtDefineFromDate;
  String? dtDefineToDate;
  double? decPointOnScanning;
  bool isExpand = false;

  DataList(
      {this.fkSchemeGlCode,
      this.fkDefineSchemeGlCode,
      this.varSchemeCode,
      this.varSchemeName,
      this.varPointBasedOn,
      this.varGroupCode,
      this.varProductSKUCode,
      this.varProductSKUName,
      this.dtDefineFromDate,
      this.dtDefineToDate,
      this.decPointOnScanning});

  DataList.fromJson(Map<String, dynamic> json) {
    fkSchemeGlCode = json['fk_SchemeGlCode'];
    fkDefineSchemeGlCode = json['fk_DefineSchemeGlCode'];
    varSchemeCode = json['varSchemeCode'];
    varSchemeName = json['varSchemeName'];
    varPointBasedOn = json['varPointBasedOn'];
    varGroupCode = json['varGroupCode'];
    varProductSKUCode = json['varProduct_SKU_Code'];
    varProductSKUName = json['varProduct_SKU_Name'];
    dtDefineFromDate = json['dtDefineFromDate'];
    dtDefineToDate = json['dtDefineToDate'];
    decPointOnScanning = json['decPointOnScanning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_SchemeGlCode'] = this.fkSchemeGlCode;
    data['fk_DefineSchemeGlCode'] = this.fkDefineSchemeGlCode;
    data['varSchemeCode'] = this.varSchemeCode;
    data['varSchemeName'] = this.varSchemeName;
    data['varPointBasedOn'] = this.varPointBasedOn;
    data['varGroupCode'] = this.varGroupCode;
    data['varProduct_SKU_Code'] = this.varProductSKUCode;
    data['varProduct_SKU_Name'] = this.varProductSKUName;
    data['dtDefineFromDate'] = this.dtDefineFromDate;
    data['dtDefineToDate'] = this.dtDefineToDate;
    data['decPointOnScanning'] = this.decPointOnScanning;
    return data;
  }
}
