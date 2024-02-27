class PreFillKeyDetails {
  int? fkPersonGlCode;
  String? varAddress;
  String? varPincode;
  String? varLatitude;
  String? varLongitude;
  int? fkL3PoliticalGeoGlCode;
  int? fkL2PoliticalGeoGlCode;
  int? fkL1PoliticalGeoGlCode;

  PreFillKeyDetails(
      {this.fkPersonGlCode,
      this.varAddress,
      this.varPincode,
      this.varLatitude,
      this.varLongitude,
      this.fkL3PoliticalGeoGlCode,
      this.fkL2PoliticalGeoGlCode,
      this.fkL1PoliticalGeoGlCode});

  PreFillKeyDetails.fromJson(Map<String, dynamic> json) {
    fkPersonGlCode = json['fk_PersonGlCode'];
    varAddress = json['varAddress'];
    varPincode = json['varPincode'];
    varLatitude = json['varLatitude'];
    varLongitude = json['varLongitude'];
    fkL3PoliticalGeoGlCode = json['fk_L3_PoliticalGeoGlCode'];
    fkL2PoliticalGeoGlCode = json['fk_L2_PoliticalGeoGlCode'];
    fkL1PoliticalGeoGlCode = json['fk_L1_PoliticalGeoGlCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_PersonGlCode'] = this.fkPersonGlCode;
    data['varAddress'] = this.varAddress;
    data['varPincode'] = this.varPincode;
    data['varLatitude'] = this.varLatitude;
    data['varLongitude'] = this.varLongitude;
    data['fk_L3_PoliticalGeoGlCode'] = this.fkL3PoliticalGeoGlCode;
    data['fk_L2_PoliticalGeoGlCode'] = this.fkL2PoliticalGeoGlCode;
    data['fk_L1_PoliticalGeoGlCode'] = this.fkL1PoliticalGeoGlCode;
    return data;
  }
}
